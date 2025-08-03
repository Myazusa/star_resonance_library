import 'dart:typed_data';
import 'package:opencv_core/opencv.dart' as cv;
import 'package:image/image.dart' as img;

import '../../util/assets_util.dart';
import '../option_module.dart';

class OpencvModule{
  static late Map<String,cv.Mat> grayQueryMatMap;

  /// 返回以窗口客户区左上角点为基准的相对位置
  /// [screenCaptureImage] 截屏获得的图片
  /// [fileName] 要匹配的文件名
  static Future<(int, int)?> processScreenCaptureImage(Uint8List screenCaptureImage,String fileName) async {
    // 获取已经读取好的目标图片的灰度图
    cv.Mat? grayQueryMat = grayQueryMatMap[fileName];
    if(grayQueryMat == null){
      return null;
    }

    // 处理截屏和目标图的单通道灰度图，以便处理效率更高
    final grayTrainMat = _convertGrayMatFromImage(
      screenCaptureImage,
      width: OptionModule.instance.gameScreenWidth,
      height: OptionModule.instance.gameScreenHeight
    );
    if(grayTrainMat == null){
      return null;
    }

    // todo: （优化）两个图片的处理应该分别使用多线程
    // 计算关键点。
    // 关键点是图像提取出来的比较有特征的点的集合
    final keyPoints = _calculateKeyPoints(grayTrainMat,grayQueryMat);
    // 计算最佳匹配。
    // 使用匹配算法计算获得匹配度大于0.75的匹配点。这个点集可能有多个所以是数组，意味着有多个符合目标图的位置。
    final goodMatches = _featureMatching(keyPoints.$1,keyPoints.$2);
    // 计算距离聚类。
    // 用匹配子和关键点计算点位置的聚类，在某一个区域内（300）则视为同一区域的点集。这个点集可能有多个所以是数组，意味着有多个符合目标图的位置。
    final cluster = _calculateDistanceClustering(goodMatches,keyPoints.$1,keyPoints.$2,300);
    // 计算单应矩阵。
    // 单应矩阵是对图片透视变换，缩放等的矩阵变换表述。这里获取每一个区域的单应矩阵，以便后续可以匹配上截屏里的区域，即时它被缩放和变形也能对应上
    final homographies = _calculateHomographiesMat(cluster,keyPoints.$1,keyPoints.$2);
    // 在目标图上应用单应矩阵的变换
    final sceneCornersMat = _applyPerspectiveTransform(grayQueryMat,homographies);
    // 计算匹配区域的中心点，这个中心点不是整个屏幕的绝对坐标值，而是以游戏窗口左上角为基准点的相对值
    (double,double) centerPoint = _calculateCenterPoint(sceneCornersMat);

    // 四舍五入取整
    return (centerPoint.$1.round(),centerPoint.$2.round());
  }

  /// 初始化，读取并把要识别的图片转为灰度矩阵存入内存中
  static Future<void> initGreyQueryMatMap() async {
    // 获取原始图片的map
    final imageMap = await AssetsUtil.loadAllImages();

    // 遍历里面的内容
    imageMap.forEach((key,value){
      final grayMat = _convertGrayMatFromImage(value);
      if(grayMat != null){
        grayQueryMatMap.putIfAbsent(key, () => grayMat).add(grayMat);
      }
    });
  }

  static Future<void> destGreyQueryMatMap() async {
    grayQueryMatMap.clear();
  }

  static cv.Mat _applyPerspectiveTransform(cv.Mat grayQueryMat,List<cv.Mat> homographies){
    // 创建目标图角点Mat
    final queryCornersData = [
      0.0, 0.0,                                   // 左上
      grayQueryMat.cols.toDouble(), 0.0,            // 右上
      grayQueryMat.cols.toDouble(), grayQueryMat.rows.toDouble(), // 右下
      0.0, grayQueryMat.rows.toDouble()             // 左下
    ];
    final queryCornersMat = cv.Mat.fromList(4,2,cv.MatType.CV_32FC1,queryCornersData
    );

    // 将单应矩阵的变换应用到目标图上，计算目标图角点相对于截屏角点变换点，得到的就是目标图在大图中的实际位置的矩阵
    // 这里取第一个也就是第一个找到的区域，其他区域即使匹配到了也在这里暂时不做处理
    final sceneCornersMat = cv.perspectiveTransform(queryCornersMat, homographies[0]);

    return sceneCornersMat;
  }

  static cv.Mat? _convertGrayMatFromImage(Uint8List image,{int width = -1,int height = -1}){
    late int imageWidth;
    late int imageHeight;
    if(width == -1 && height == -1){
      final imageSize = _getImageSize(image);

      if(imageSize == null){
        return null;
      }

      imageWidth = imageSize.$1;
      imageHeight = imageSize.$2;
    }else{
      imageWidth = width;
      imageHeight = height;
    }

    final imageMat = cv.Mat.create(
        rows: imageHeight,
        cols: imageWidth,
        type: cv.MatType.CV_8UC4
    );
    imageMat.data.setAll(0, image);

    // 交换RB，因为截屏得到的是RGBA，而opencv要的是GBRA
    _swapRAndB(imageMat);

    // 处理截屏和目标图的单通道灰度图，以便处理效率更高
    return cv.cvtColor(imageMat, cv.COLOR_BGRA2GRAY);
  }

  static (int,int)? _getImageSize(Uint8List data) {
    final decoded = img.decodeImage(data);
    if (decoded != null) {
      return (decoded.width,decoded.height);
    }else{
      return null;
    }
  }

  static (double,double) _calculateCenterPoint(cv.Mat sceneCornersMat){
    double sumX = 0.0;
    double sumY = 0.0;

    // 解包矩阵，计算四个角坐标平均值以获得中心点
    for (var i = 0; i < sceneCornersMat.data.length; i += 2) {
      sumX += sceneCornersMat.data[i];
      sumY += sceneCornersMat.data[i+1];
    }
    final centerX = sumX / 4;
    final centerY = sumY / 4; // 直接除以4，和用（已知四边形四个点坐标求中心点坐标公式）是一样的

    return (centerX,centerY);
  }

  static ((cv.VecKeyPoint, cv.Mat),(cv.VecKeyPoint, cv.Mat)) _calculateKeyPoints(cv.Mat trainMat,cv.Mat queryMat){
    // 创建对应的灰度图Mask
    final queryKeyPointMask = cv.Mat.ones(queryMat.rows, queryMat.cols, cv.MatType.CV_8UC1);
    final trainKeyPointMask = cv.Mat.ones(trainMat.rows, trainMat.cols, cv.MatType.CV_8UC1);

    // 创建ORB检测器进行ORB特征检测，计算检测关键点和描述子
    final orb = cv.ORB.create();
    final queryKeyPoint = orb.detectAndCompute(queryMat,queryKeyPointMask); // 此函数是双返回值，第二个值有用
    final trainKeyPoint = orb.detectAndCompute(trainMat,trainKeyPointMask);
    return (queryKeyPoint,trainKeyPoint);
  }

  static List<cv.DMatch> _featureMatching((cv.VecKeyPoint, cv.Mat) queryKeyPoint,(cv.VecKeyPoint, cv.Mat) trainKeyPoint){
    // 使用knn算法进行匹配描述子
    final bf = cv.BFMatcher.create(type: cv.NORM_HAMMING,crossCheck: true);
    final knnMatches = bf.knnMatch(queryKeyPoint.$2, trainKeyPoint.$2, 2); // 这里要第二个参数来计算匹配点

    // 获取最佳的匹配
    final goodMatches = <cv.DMatch>[];
    for (final m in knnMatches) {
      if (m[0].distance < 0.75 * m[1].distance) {
        goodMatches.add(m[0]);
      }
    }

    return goodMatches;
  }

  static List<List<cv.DMatch>> _calculateDistanceClustering(List<cv.DMatch> goodMatches,(cv.VecKeyPoint, cv.Mat) queryKeyPoint,(cv.VecKeyPoint, cv.Mat) trainKeyPoint, double eps){
    final clusters = <List<cv.DMatch>>[];

    for (final m in goodMatches) {
      final pt = trainKeyPoint.$1[m.trainIdx];
      bool added = false;

      for (final cluster in clusters) {
        final firstPt = trainKeyPoint.$1[cluster[0].trainIdx];
        final dx = pt.x - firstPt.x;
        final dy = pt.y - firstPt.y;
        final dist2 = dx * dx + dy * dy;

        if (dist2 < eps * eps) {
          cluster.add(m);
          added = true;
          break;
        }
      }

      if (!added) {
        clusters.add([m]);
      }
    }
    return clusters;
  }

  static List<cv.Mat>_calculateHomographiesMat(List<List<cv.DMatch>> clusters,(cv.VecKeyPoint, cv.Mat) queryKeyPoint,(cv.VecKeyPoint, cv.Mat) trainKeyPoint){
    final homographies = <cv.Mat>[];

    for (final cluster in clusters) {
      if (cluster.length < 4) continue; // 至少需要4对点

      final ptsQuery = <double>[];
      final ptsTrain = <double>[];

      for (final m in cluster) {
        final q = queryKeyPoint.$1[m.queryIdx];
        final t = trainKeyPoint.$1[m.trainIdx];
        ptsQuery.addAll([q.x, q.y]);
        ptsTrain.addAll([t.x, t.y]);
      }

      // 把这两个匹配特征点数组转化为矩阵
      final mat1 = cv.Mat.fromList(
          cluster.length, 2, cv.MatType.CV_32FC1, ptsQuery);
      final mat2 = cv.Mat.fromList(
          cluster.length, 2, cv.MatType.CV_32FC1, ptsTrain);

      // 计算单应矩阵
      final homography = cv.findHomography(mat1, mat2, method: cv.RANSAC);
      homographies.add(homography);
    }
    return homographies;
  }

  static void _swapRAndB(cv.Mat mat) {
    final data = mat.data;
    for (var i = 0; i < data.length; i += 4) {
      final r = data[i];
      data[i] = data[i + 2];       // R转B
      data[i + 2] = r;             // B转R
    }
  }
}
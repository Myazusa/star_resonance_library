
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../page/fishing_page.dart';
import '../page/info_page.dart';
import '../page/option_page.dart';

final router = GoRouter(
    initialLocation: '/info',
    routes: [
      ShellRoute(
          builder: (context, state ,child) => MainLayout(child: child),
          routes: [
            GoRoute(
                path: '/info',
                builder: (context, state) => InfoPage()
            ),
            GoRoute(
                path: '/auto_fishing',
                builder: (context, state) => FishingPage()
            ),
            GoRoute(
                path: '/option',
                builder: (context, state) => OptionPage()
            )
          ]
      )
    ]
);

import 'package:go_router/go_router.dart';

import 'package:star_resonance_toolkit/main.dart';
import 'package:star_resonance_toolkit/ui/page/fishing_page.dart';
import 'package:star_resonance_toolkit/ui/page/info_page.dart';
import 'package:star_resonance_toolkit/ui/page/option_page.dart';

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
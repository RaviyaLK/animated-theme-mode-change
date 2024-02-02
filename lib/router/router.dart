import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:theme_mode_change/constants/constants.dart';
import 'package:theme_mode_change/home_screen.dart';

part 'route_transition.dart';

final routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: kDebugMode,
  initialLocation: HomeScreen.path,
  routes: [
    GoRoute(
        path: HomeScreen.path,
        pageBuilder: (context, state) => pageTransition(
            context, state, const HomeScreen(),
            restorationId: HomeScreen.path,
            type: SlideTransitionType.rightToLeft)),
  ],
);

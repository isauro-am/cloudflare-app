import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppNavigator {
  AppNavigator._();

  static navigator(BuildContext context, String route) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            appRoutes[route]!(context),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}

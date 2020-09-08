import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import '../screens/spy_screen.dart';
import '../screens/qr_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    MainScreen.route: (context) => MainScreen(),
    SpyScreen.route: (context) => SpyScreen(),
    QrScreen.route: (context) => QrScreen(),
  };
}

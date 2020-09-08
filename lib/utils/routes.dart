import 'package:flutter/material.dart';

import '../screens/export_qr_screen.dart';
import '../screens/main_screen.dart';
import '../screens/read_qr_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    MainScreen.route: (context) => MainScreen(),
    ReadQrScreen.route: (context) => ReadQrScreen(),
    ExportQrScreen.route: (context) => ExportQrScreen(),
  };
}

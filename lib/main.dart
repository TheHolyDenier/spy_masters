import 'package:flutter/material.dart';

import './screens/main_screen.dart';
import './utils/palette.dart';
import './utils/routes.dart';
import './utils/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      theme: ThemeData(
        primarySwatch: Palette.primaryWatch,
        accentColor: Palette.accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Palette.background,
        textTheme: TextTheme(
          headline3: TextStyle(fontFamily: 'Fjalla', color: Palette.white),
          headline6: TextStyle(fontFamily: 'Fjalla', color: Palette.white),
          bodyText1: TextStyle(fontFamily: 'Lato', color: Palette.killer),
          bodyText2: TextStyle(fontFamily: 'Lato', color: Palette.white),
        ),
      ),
      initialRoute: MainScreen.route,
      routes: Routes.routes,
    );
  }
}

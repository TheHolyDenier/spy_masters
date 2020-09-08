import 'package:flutter/material.dart';

//SCREENS
import '../main_screen.dart';

//MODELS

//UTILS
import '../../utils/palette.dart';
import '../../utils/strings.dart';

class SureWidget extends StatelessWidget {
  final function;

  SureWidget({this.function});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: AlertDialog(
        title: Text(Strings.title_sure_dialog.toUpperCase()),
        content: Text(Strings.warning_changes),
        elevation: 24,
        backgroundColor: Palette.white,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              Strings.go_back.toUpperCase(),
            ),
          ),
          FlatButton(
            onPressed: () => function != null ? _callFunction(context) : Navigator.of(context)
                .pushNamedAndRemoveUntil(MainScreen.route, (route) => false),
            child: Text(
              Strings.new_game.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }

  _callFunction(BuildContext context) {
    Navigator.pop(context);
    function();
  }
}

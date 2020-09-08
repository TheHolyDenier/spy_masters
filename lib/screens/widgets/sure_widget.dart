import 'package:flutter/material.dart';

//SCREENS
import '../main_screen.dart';

//MODELS

//UTILS
import '../../utils/palette.dart';
import '../../utils/strings.dart';

class SureWidget extends StatelessWidget {
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
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(MainScreen.route, (route) => false);
              // Navigator.popAndPushNamed(context, MainScreen.route);
            },
            child: Text(
              Strings.new_game.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}

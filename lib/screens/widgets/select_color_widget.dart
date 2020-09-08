import 'package:flutter/material.dart';

//SCREENS

//MODELS
import '../../models/enums/card_type.dart';

//UTILS

class SelectColorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var type in CardType.values)
            ListTile(
              onTap: () {
                Navigator.pop(context, type);
              },
              leading: ClipOval(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: type.color),
                ),
              ),
              title: Text(type.toText),
            )
        ],
      ),
    );
  }
}

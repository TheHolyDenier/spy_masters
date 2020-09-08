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
        children: [
          for (var type in CardType.values)
            InkWell(
              onTap: () => type,
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      decoration: BoxDecoration(color: type.color),
                    ),
                  ),
                  Text(type.toText)
                ],
              ),
            )
        ],
      ),
    );
  }
}

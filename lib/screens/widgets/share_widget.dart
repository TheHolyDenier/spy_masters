import 'package:flutter/material.dart';

//LIBRARIES
import 'package:qr_flutter/qr_flutter.dart';

//SCREENS

//MODELS

//UTILS
import '../../utils/palette.dart';
import '../../utils/strings.dart';

class ShareWidget extends StatelessWidget {
  final index;
  final args;
  final function;

  ShareWidget(this.index, this.args, this.function);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          index == 0
              ? Strings.export_spy.toUpperCase()
              : Strings.export_players.toUpperCase(),
          style: Theme.of(context).textTheme.headline3,
        ),
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Palette.white,
          ),
          child: QrImage(
            data: '$args',
          ),
        ),
        RaisedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Strings.share.toUpperCase()),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.send)
            ],
          ),
        ),
      ],
    );
  }
}

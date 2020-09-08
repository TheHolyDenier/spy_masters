import 'package:flutter/material.dart';
import 'package:spy_masters/models/enums/card_type.dart';
import 'package:spy_masters/utils/palette.dart';
import 'package:spy_masters/utils/strings.dart';

class NewGameWidget extends StatefulWidget {
  @override
  _NewGameWidgetState createState() => _NewGameWidgetState();
}

class _NewGameWidgetState extends State<NewGameWidget> {
  final _total = 25;
  var _noUsed = 0;
  final Map<CardType, int> gameConfiguration = {
    CardType.NEUTRAL: 7,
    CardType.KILLER: 1,
    CardType.BLUE_TEAM: 9,
    CardType.RED_TEAM: 8
  };

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var card in gameConfiguration.keys)
              ListTile(
                leading: ClipOval(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: card.color),
                  ),
                ),
                title: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(width: 100, child: Text(card.toText)),
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Palette.primaryWatch,
                      ),
                      onPressed: _noUsed < _total ? () => _rest(card) : null,
                    ),
                    Container(
                        width: 20,
                        child: Text(
                          '${gameConfiguration[card]}',
                          textAlign: TextAlign.center,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Palette.primaryWatch,
                      ),
                      onPressed: _noUsed > 0 ? () => _sum(card) : null,
                    )
                  ],
                ),
              ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Strings.def.toUpperCase()),
          ),
          FlatButton(
              onPressed: _total ==
                      gameConfiguration.values
                          .reduce((value, element) => value + element)
                  ? _saveGame
                  : null,
              child: Text('${Strings.save.toUpperCase()} ($_noUsed)'))
        ],
      ),
    );
  }

  void _saveGame() => Navigator.pop(context, gameConfiguration);

  _sum(CardType card) {
    setState(() {
      gameConfiguration[card]++;
      _noUsed--;
    });
  }

  _rest(CardType card) {
    if (gameConfiguration[card] > 0)
      setState(() {
        gameConfiguration[card]--;
        _noUsed++;
      });
  }
}

import 'package:flutter/material.dart';

//SCREENS
import './select_color_widget.dart';

//MODELS
import '../../models/enums/card_type.dart';
import '../../models/game_card.dart';

//UTILS
import '../../utils/palette.dart';

class CardWidget extends StatefulWidget {
  final GameCard card;
  final bool isGame;

  CardWidget(this.card, {this.isGame});

  @override
  _CardWidgetState createState() => _CardWidgetState(card, isGame: isGame);
}

class _CardWidgetState extends State<CardWidget> {
  final GameCard _card;
  bool isGame;

  _CardWidgetState(this._card, {this.isGame});

  @override
  Widget build(BuildContext context) {
    CardType cardType = _card.cardType;
    return InkWell(
      onLongPress: () {},
      onTap: onClick,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: _card.isRevealed ? cardType.color : Palette.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _card.text.toUpperCase(),
                  style: _card.isRevealed
                      ? Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onClick() async {
    if (!_card.isRevealed) {
      if (!isGame) {
        _card.cardType = await askTeam();
      }
      setState(() {
        _card.isRevealed = true;
      });
    }
  }

  Future<CardType> askTeam() {
    return showDialog(
      context: context,
      builder: (context) => SelectColorWidget(),
    );
  }
}

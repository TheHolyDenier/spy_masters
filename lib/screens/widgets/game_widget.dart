import 'package:flutter/material.dart';

//SCREENS
import './card_widget.dart';

//MODELS
import '../../models/enums/card_type.dart';
import '../../models/game_card.dart';

//UTILS
import '../../utils/codes.dart';

class GameWidget extends StatelessWidget {
  const GameWidget(this.randomWords, this.random,
      {this.isSpy = false, this.isGame = true});

  final List<int> randomWords;
  final List<int> random;
  final bool isSpy, isGame;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: GridView.count(
          childAspectRatio: itemHeight / itemWidth,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          children: [
            for (var index in randomWords)
              CardWidget(
                  GameCard(
                    SpyReport.clues[index],
                    CardType.values[random[randomWords.indexOf(index)]],
                    isSpy,
                  ),
                  isGame: isGame),
          ],
        ),
      ),
    );
  }
}

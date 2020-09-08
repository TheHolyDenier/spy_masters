import './enums/card_type.dart';

class GameCard {
  String text;
  CardType cardType;
  bool isRevealed;

  GameCard(this.text, this.cardType, this.isRevealed);
}
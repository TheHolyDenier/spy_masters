import 'package:spy_masters/models/enums/card_type.dart';

import './codes.dart';

class GameGenerator {
  static const _gameConfiguration = {
    CardType.NEUTRAL: 7,
    CardType.KILLER: 1,
    CardType.BLUE_TEAM: 9,
    CardType.RED_TEAM: 8
  };

  static List<int> genDistribution(
      {Map<CardType, int> options}) {
    if (options == null) options = _gameConfiguration;
    List<int> list = [];
    for (var card in options.keys) {
      list.addAll(List.filled(options[card], card.value));
    }
    return list..shuffle();
  }

  static List<int> getWords(int length) {
    var list = new List<int>.generate(SpyReport.clues.length - 1, (i) => i + 1);

    return List.from(List.from(list..shuffle()).getRange(0, length));
  }
}

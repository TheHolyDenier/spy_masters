import './codes.dart';

class GameGenerator {
  static List<int> roles = [
    0, //1
    1, //1 TOWN
    1,
    1,
    1,
    1,
    1,
    1,
    2, //1 BLUE
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    3, //1 RED
    3,
    3,
    3,
    3,
    3,
    3,
    3
  ];

  static List<int> genDistribution() {
    return List.from(roles)..shuffle();
  }

  static List<int> getWords() {
    var list = new List<int>.generate(SpyReport.clues.length -1, (i) => i + 1);

    return List.from(List.from(list..shuffle()).getRange(0, roles.length));
  }
}

import 'package:flutter/material.dart';

class GameArgs {
  List<int> random;
  List<int> randomWords;

  GameArgs({@required this.random, @required this.randomWords});

  @override
  String toString() {
    return '${random}_$randomWords';
  }
}

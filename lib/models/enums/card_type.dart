import 'package:flutter/material.dart';

import '../../utils/palette.dart';
import '../../utils/strings.dart';

enum CardType { KILLER, NEUTRAL, BLUE_TEAM, RED_TEAM, UNKNOWN }

extension CardExtension on CardType {
  Color get color {
    switch (this) {
      case CardType.NEUTRAL:
        return Palette.neutral;
      case CardType.BLUE_TEAM:
        return Palette.blueTeam;
      case CardType.RED_TEAM:
        return Palette.redTeam;
      case CardType.KILLER:
        return Palette.killer;
      default:
        return Palette.white;
    }
  }

  int get value {
    switch (this) {
      case CardType.NEUTRAL:
        return 1;
      case CardType.BLUE_TEAM:
        return 2;
      case CardType.RED_TEAM:
        return 3;
      case CardType.KILLER:
        return 0;
      default:
        return 4;
    }
  }

  String get toText {
    switch (this) {
      case CardType.NEUTRAL:
        return Strings.neutral;
      case CardType.BLUE_TEAM:
        return Strings.team_blue;
      case CardType.RED_TEAM:
        return Strings.team_red;
      case CardType.KILLER:
        return Strings.killer;
      default:
        return Strings.unknown;
    }
  }
}

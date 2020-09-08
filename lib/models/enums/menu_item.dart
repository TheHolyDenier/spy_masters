import 'package:flutter/material.dart';

import '../../utils/strings.dart';
import '../../utils/icons.dart';

enum MenuItem { SCAN_QR, READ_QR }

extension MenuItemExtension on MenuItem {
  String get string {
    switch (this) {
      case MenuItem.READ_QR:
        return Strings.read_qr;
      case MenuItem.SCAN_QR:
        return Strings.scan_qr;
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuItem.READ_QR:
        return MyIcons.qr_reader;
      case MenuItem.SCAN_QR:
        return MyIcons.qr_scanner;
      default:
    }
  }
}

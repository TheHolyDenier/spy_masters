import 'package:flutter/material.dart';

//SCREENS
import './export_qr_screen.dart';
import './read_qr_screen.dart';
import './widgets/game_widget.dart';
import './widgets/sure_widget.dart';

//MODELS
import '../models/enums/menu_item.dart';
import '../models/game_args.dart';

//UTILS
import '../utils/generator.dart';
import '../utils/palette.dart';
import '../utils/strings.dart';

class MainScreen extends StatefulWidget {
  static final route = "/";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<int> _random = [];
  List<int> _randomWords = [];

  _MainScreenState() {
    if (_random.length == 0) {
      randomize();
    }
  }

  void randomize() {
    _random = GameGenerator.genDistribution();
    _randomWords = GameGenerator.getWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        title: Text(
          Strings.app_name.toUpperCase(),
          style: TextStyle(fontFamily: 'Fjalla'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.loop),
            onPressed: _newGame,
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return MenuItem.values.map((MenuItem choice) {
                return PopupMenuItem<MenuItem>(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(choice.icon, color: Palette.killer),
                      SizedBox(
                        width: 5,
                      ),
                      Text(choice.string)
                    ],
                  ),
                  value: choice,
                );
              }).toList();
            },
            onSelected: _handleClick,
          ),
        ],
      ),
      body: GameWidget(_randomWords, _random),
    );
  }

  void _newGame() {
    showDialog(
      context: context,
      builder: (_) => SureWidget(),
      barrierDismissible: true,
    );
  }

  void _scanQr() {
    Navigator.pushNamed(context, ReadQrScreen.route);
  }

  void _handleClick(MenuItem value) {
    switch (value) {
      case MenuItem.READ_QR:
        Navigator.pushNamed(context, ExportQrScreen.route,
            arguments: GameArgs(random: _random, randomWords: _randomWords));
        break;
      case MenuItem.SCAN_QR:
        _scanQr();
        break;
    }
  }
}

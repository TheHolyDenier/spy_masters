import 'package:flutter/material.dart';
import 'package:spy_masters/models/enums/card_type.dart';
import 'package:spy_masters/screens/widgets/new_game_widget.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_random.isEmpty && _randomWords.isEmpty) _createNewGame();

    });
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
      body: _randomWords.isNotEmpty && _random.isNotEmpty
          ? GameWidget(_randomWords, _random)
          : Container(),
    );
  }

  Future<void> _newGame() async {
    int reply = await showDialog(
      context: context,
      builder: (_) => SureWidget(),
      barrierDismissible: true,
    );
    if (reply == 1) {
      setState(() {
        _random = [];
        _randomWords = [];
      });
      _createNewGame();
    }
  }

  Future<void> _createNewGame() async {
    Map<CardType, int> options = await showDialog(
        context: context,
        builder: (_) => NewGameWidget(),
        barrierDismissible: false);

    setState(() {
      _random = GameGenerator.genDistribution(options: options ?? null);
      _randomWords = GameGenerator.getWords(_random.length);
    });
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

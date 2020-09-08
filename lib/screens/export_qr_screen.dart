import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//LIBRARIES
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

//SCREENS
import './widgets/game_widget.dart';
import './widgets/no_permissions_widget.dart';
import './widgets/share_widget.dart';

//MODELS
import '../models/game_args.dart';

//UTILS
import '../utils/palette.dart';
import '../utils/strings.dart';
import '../utils/permission.dart';

class ExportQrScreen extends StatefulWidget {
  static final route = "/export";

  @override
  _ExportQrScreenState createState() => _ExportQrScreenState();
}

class _ExportQrScreenState extends State<ExportQrScreen> {
  final _controller = PageController(initialPage: 0);
  GlobalKey _masterSpyKey = GlobalKey();
  GlobalKey _playerKey = GlobalKey();
  int _index = 0;
  var _gettingImage = false;
  bool _permissions;

  void _capturePng(GlobalKey key) async {
    setState(() {
      _gettingImage = true;
    });
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();

    if (!boundary.debugNeedsPaint) {
      try {
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);

        final file = File(
            '${(await getTemporaryDirectory()).path}/code_name_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        Share.shareFiles([file.path], subject: Strings.send_data);
      } catch (e) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(Strings.error_share),
          action: SnackBarAction(
            label: 'Action',
            onPressed: () {},
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        print('${ExportQrScreen.route} error: $e');
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 20));
      _capturePng(key);
    }

    setState(() {
      _gettingImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_permissions == null) _askPermissions();
    final GameArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        title: Text(
          Strings.qr.toUpperCase(),
          style: TextStyle(fontFamily: 'Fjalla'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.primaryWatch,
        selectedItemColor: Palette.killer,
        unselectedItemColor: Palette.killer.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
            _controller.animateToPage(
              _index,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            label: Strings.export_spy,
            icon: Icon(Icons.whatshot_outlined),
          ),
          BottomNavigationBarItem(
            label: Strings.export_players,
            icon: Icon(Icons.people_alt_outlined),
          ),
        ],
      ),
      body: _permissions
          ? Stack(
              fit: StackFit.expand,
              children: [
                RepaintBoundary(
                  key: _masterSpyKey,
                  child: GameWidget(args.randomWords, args.random,
                      isSpy: _index == 0, isGame: false),
                ),
                RepaintBoundary(
                  key: _playerKey,
                  child: GameWidget(
                    args.randomWords,
                    _index == 0
                        ? args.random
                        : List.filled(args.randomWords.length, -1),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Palette.background),
                  child: Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          _index = value;
                        });
                      },
                      controller: _controller,
                      children: [
                        ShareWidget(0, args, _getImage),
                        ShareWidget(1, args, _getImage)
                      ],
                    ),
                  ),
                ),
              ],
            )
          : NoPermissionWidget(false, _askPermissions),
    );
  }

  Future<void> _askPermissions() async {
    _permissions = false;
    _permissions = await AskPermission.checkStorage();
    setState(() {});
  }

  void _getImage() {
    if (!_gettingImage) {
      _capturePng(_index == 0 ? _masterSpyKey : _playerKey);
    }
  }
}

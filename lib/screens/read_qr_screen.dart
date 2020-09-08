import 'package:flutter/material.dart';

//LIBRARIES
import 'package:barcode_scan/barcode_scan.dart';

//SCREENS
import './widgets/game_widget.dart';
import './widgets/no_permissions_widget.dart';
import './widgets/sure_widget.dart';

//MODELS

//UTILS
import '../utils/palette.dart';
import '../utils/strings.dart';
import '../utils/icons.dart';
import '../utils/permission.dart';

class ReadQrScreen extends StatefulWidget {
  static final route = "/read_qr";

  @override
  _ReadQrScreenState createState() => _ReadQrScreenState();
}

class _ReadQrScreenState extends State<ReadQrScreen> {
  List<int> _random = [];
  List<int> _randomWords = [];

  bool _permissions;
  bool _isSpyMaster = false;

  @override
  Widget build(BuildContext context) {
    if (_permissions == null) _askPermissions();
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        title: Text(
          Strings.scan_qr.toUpperCase(),
          style: TextStyle(fontFamily: 'Fjalla'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [IconButton(icon: Icon(MyIcons.qr_scanner), onPressed: _random.isEmpty ? _scan : _newScan)],
      ),
      body: _permissions
          ? Stack(
              fit: StackFit.expand,
              children: [
                _random.isNotEmpty && _randomWords.isNotEmpty
                    ? GameWidget(
                        _randomWords,
                        _random,
                        isSpy: _isSpyMaster,
                        isGame: false,
                      )
                    : Container(
                        margin: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Strings.error_qr,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
              ],
            )
          : NoPermissionWidget(true, _askPermissions),
    );
  }

  void _newScan() {
    showDialog(
      context: context,
      builder: (_) => SureWidget(function: _scan),
      barrierDismissible: true,
    );
  }


  Future<void> _scan() async {
    setState(() {
      _random = [];
      _randomWords = [];
    });
    var result = await BarcodeScanner.scan();

    try {
      var lists = result.split('_');
      setState(() {
        _random = lists[0]
            .substring(1, lists[0].length - 1)
            .split(', ')
            .map(int.parse)
            .toList();
        _randomWords = lists[1]
            .substring(1, lists[1].length - 1)
            .split(', ')
            .map(int.parse)
            .toList();
        _isSpyMaster = !_random.contains(4);
      });
    } catch (e) {
      print('${ReadQrScreen.route} error: $e');
    }
  }

  Future<void> _askPermissions() async {
    _permissions = false;
    _permissions = await AskPermission.checkCamera();
    setState(() {});
  }
}

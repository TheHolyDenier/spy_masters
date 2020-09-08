import 'package:flutter/material.dart';

//SCREENS

//MODELS

//UTILS
import '../../utils/strings.dart';

class NoPermissionWidget extends StatelessWidget {
  final bool _camera;
  final Function _function;

  NoPermissionWidget(this._camera, this._function);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${Strings.ask_permissions} ${_camera ? Strings.camera : Strings.storage}',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: _function,
            child: Text(
              Strings.permissions.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}

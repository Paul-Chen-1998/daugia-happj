import 'package:flutter/material.dart';

import 'auth_service.dart';

class Provider extends InheritedWidget {
  final AuthService auth;

  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static Provider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Provider);
}

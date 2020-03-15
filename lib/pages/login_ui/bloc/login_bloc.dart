import 'dart:async';

import 'package:flutterhappjapp/pages/login_ui/validator/validations.dart';



class LoginBloc {
  StreamController _controllerUser = new StreamController();
  StreamController _controllerPassword = new StreamController();

  Stream get userStream => _controllerUser.stream;

  Stream get passStream => _controllerPassword.stream;

  bool isValidInfo(String user, String pass) {

    if (!ValidationsLogin.isValidUser(user)) {
      _controllerUser.sink.addError('User not avaliable !!!');
      if(!ValidationsLogin.isValidPassword(pass)){
        _controllerPassword.sink.addError('Password not avaliable !!!');
      }
      return false;
    }
    _controllerUser.sink.add('ok');
    if(!ValidationsLogin.isValidPassword(pass)){
      _controllerPassword.sink.addError('Password not avaliable !!!');
      return false;
    }
    _controllerPassword.sink.add('ok');
    return true;
  }

  void dispose() {
    _controllerUser.close();
    _controllerPassword.close();
  }
}

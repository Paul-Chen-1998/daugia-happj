import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/User/add_product.dart';
import 'package:flutterhappjapp/pages/login_ui/authencaiton_signup.dart';

import 'package:flutterhappjapp/pages/login_ui/page_main.dart';
import 'package:flutterhappjapp/pages/login_ui/sign_up.dart';
import 'package:flutterhappjapp/pages/page_main/page_main_product.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:flutterhappjapp/utils/auth_service.dart';
import 'package:flutterhappjapp/utils/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Provider(
      auth: AuthService(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => SignUp(
                authFormType: AuthFormType.signUp,
              ),
          '/reset': (BuildContext context) => SignUp(
            authFormType: AuthFormType.reset,
          ),
          '/signin': (BuildContext context) => SignUp(
                authFormType: AuthFormType.signIn,
              ),
          '/home': (BuildContext context) => HomeController(),
          '/skip': (BuildContext context) => Main(),
          '/authentication': (BuildContext context) => Authentication()

        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  SharedPreferences sharedPreferences;

  Future<String> checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return FutureBuilder(
      future: checkLoginStatus(),
      // ignore: missing_return
      builder: (context,AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        else{
          String token = snapshot.data;
          print( token);
          return token != null ? Main() : LoginPage();
        }
      },
    );
//      StreamBuilder(
//      stream: auth.onAuthStateChanged,
//      // ignore: missing_return
//      builder: (context, AsyncSnapshot<String> snapshot) {
//        if (snapshot.connectionState == ConnectionState.active) {
//          final bool signedIn = snapshot.hasData;
//          return signedIn ? Main() : LoginPage();
//        }
//        return SplashPage();
//      },
//    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutterhappjapp/pages/login_ui/page_main.dart';
import 'package:flutterhappjapp/pages/login_ui/sign_up.dart';
import 'package:flutterhappjapp/pages/page_main/page_main_product.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:flutterhappjapp/utils/auth_service.dart';
import 'package:flutterhappjapp/utils/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Provider(
      auth: AuthService(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/convertUser': (BuildContext context) => SignUp(authFormType: AuthFormType.convertUser,),
          '/signup': (BuildContext context) => SignUp(authFormType: AuthFormType.signUp,),
          '/signin': (BuildContext context) => SignUp(authFormType: AuthFormType.signIn,),
          '/anonymousSigniIn': (BuildContext context) => SignUp(authFormType: AuthFormType.anonymously,),
          '/home': (BuildContext context) => HomeController(),
          ///convertUser
          ///
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Main() : LoginPage();
        }
        return SplashPage();
      },
    );
  }
}


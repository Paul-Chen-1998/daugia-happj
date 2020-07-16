import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/LichSuGiaoDich.dart';
import 'package:flutterhappjapp/pages/SanPhamDangThang.dart';
import 'package:flutterhappjapp/pages/SanPhamThang.dart';
import 'package:flutterhappjapp/pages/TheLoaiSanPham.dart';
import 'package:flutterhappjapp/pages/User/HoSo.dart';
import 'package:flutterhappjapp/pages/HomePage.dart';
import 'package:flutterhappjapp/pages/SanPhamDangThua.dart';
import 'package:flutterhappjapp/src/circle_navigation_bar/circle_navigation_bar.dart';



class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      home: MyHomePage(),
    );
  }

  _configureFirebase() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          final notification = message['notification'];
          final String body = notification['body'];
          botToast(body);

        }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');

    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');

    });
  }
  botToast(String text){
    BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.add_alert, color: Colors.redAccent),
              onPressed: cancel,
            )),
        title: (_) => Text('Thông báo'),
        subtitle: (_) => Text(text),
        trailing: (cancel) => IconButton(
          icon: Icon(Icons.cancel),
          onPressed: cancel,
        ),
        onTap: () {
          BotToast.showText(text: 'Tap toast');
        },
        enableSlideOff: true,
        crossPage: true,
        duration: Duration(seconds: 5),
        animationDuration:
        Duration(milliseconds: 500),
        animationReverseDuration:
        Duration(milliseconds: 500),
        contentPadding:EdgeInsets.all(4)
        );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage (),
    SanPhamDangThang (),
    SanPhamDangThua(),
    SanPhamThang (),
    LichSuGiaoDich(),
    TheLoaiSanPham(),
    HoSoPage (),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CircleNavigationBar(
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        circleIcons: [
          CustomIcon(icon: new Image.asset('images/menu/win.png'),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamDangThang();
                  currentTab = 4;
                });
              }),
          CustomIcon(icon: new Image.asset('images/menu/lose.png'),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamDangThua();
                  currentTab = 5;
                });
              }),
          CustomIcon(icon: new Image.asset('images/menu/call.png'),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamThang();
                  currentTab = 6;
                });
              }),
        ],
        navBarIcons: [
          CustomIcon(icon: new Image.asset('images/menu/bid.png'),
              onPressed: () {
            setState(() {
              currentScreen = HomePage();
              currentTab = 0;
            });
          }),
          CustomIcon(icon: new Image.asset('images/menu/category.png'),
              onPressed: () {
            setState(() {
              currentScreen = TheLoaiSanPham();
              currentTab = 1;
            });
          }),
    CustomIcon(icon: new Image.asset('images/menu/confirm.png'),  onPressed: () {
            setState(() {
              currentScreen = LichSuGiaoDich();
              currentTab = 2;
            });
          }),
          CustomIcon(icon: new Image.asset('images/menu/user.png'),  onPressed: () {
            setState(() {
              currentScreen = HoSoPage();
              currentTab = 3;
            });
          }),
        ],
        margin: 12.0,
        borderRadius: BorderRadius.circular(10),
      )
    );
  }
}

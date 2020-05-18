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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
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

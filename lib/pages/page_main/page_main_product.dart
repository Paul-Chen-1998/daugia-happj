import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/LichSuGiaoDich.dart';
import 'package:flutterhappjapp/pages/SanPhamDangThang.dart';
import 'package:flutterhappjapp/pages/SanPhamThang.dart';
import 'package:flutterhappjapp/pages/TheLoaiSanPham.dart';
import 'package:flutterhappjapp/pages/User/HoSo.dart';
import 'package:flutterhappjapp/pages/HomePage.dart';
import 'package:flutterhappjapp/pages/SanPhamDangThua.dart';
import 'package:flutterhappjapp/src/circle_navigation_bar/circle_navigation_bar.dart';
import 'package:flutterhappjapp/ui/splash.dart';


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
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      bottomNavigationBar:  CircleNavigationBar(
        circleIcons: [
          CustomIcon(
              icon: Icon(CommunityMaterialIcons.clock),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamDangThang();
                  currentTab = 4;
                });
              }),
          CustomIcon(
              icon: Icon(CommunityMaterialIcons.clock_alert),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamDangThua();
                  currentTab = 5;
                });
              }),
          CustomIcon(
              icon: Icon(CommunityMaterialIcons.cart),
              onPressed: () {
                setState(() {
                  currentScreen = SanPhamThang();
                  currentTab = 6;
                });
              }),
        ],
        navBarIcons: [
          CustomIcon(icon: Icon(Icons.home),  onPressed: () {
            setState(() {
              currentScreen = HomePage();
              currentTab = 0;
            });
          }),
          CustomIcon(icon: Icon(Icons.menu),  onPressed: () {
            setState(() {
              currentScreen = TheLoaiSanPham();
              currentTab = 1;
            });
          }),
          CustomIcon(icon: Icon(Icons.history),  onPressed: () {
            setState(() {
              currentScreen = LichSuGiaoDich();
              currentTab = 2;
            });
          }),
          CustomIcon(icon: Icon(Icons.supervised_user_circle),  onPressed: () {
            setState(() {
              currentScreen = HoSoPage();
              currentTab = 3;
            });
          }),
        ],
        margin: 12.0,
        borderRadius: BorderRadius.circular(10),
      ),

    );
  }
}

import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/DonHang.dart';
import 'package:flutterhappjapp/pages/GioHang.dart';
import 'package:flutterhappjapp/pages/HoSo.dart';
import 'package:flutterhappjapp/pages/HomePage.dart';
import 'package:flutterhappjapp/pages/YeuThich.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwapPage(),
    );
  }
}

class SwapPage extends StatefulWidget {
  @override
  _SwapPageState createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  int _page = 0;
  final HomePage _homePage = HomePage();
  final PageDonHang _dauGia = new PageDonHang();
  final GioHang _gioHang = new GioHang();
  final PageYeuThich _donHang = new PageYeuThich();
  final PageHoSo _hoSo = new PageHoSo();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homePage;
        break;
      case 1:
        return _dauGia;
        break;
      case 2:
        return _gioHang;
        break;
      case 3:
        return _donHang;
        break;
      case 4:
        return _hoSo;
        break;
    }
  }

  Widget _icon(IconData icon, Color color) {
    return Icon(
      icon,
      color: color,
      size: 45,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _showPage,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white70,
        backgroundColor: Colors.green[100],
        buttonBackgroundColor: Colors.white,
//        animationCurve: Curves.bounceOut,
        animationDuration: Duration(milliseconds: 400),
        index: 0,
        items: <Widget>[
          _icon(CommunityMaterialIcons.hammer,
              !(_page == 0) ? Colors.black : Colors.green[800]),
          _icon(CommunityMaterialIcons.checkbox_marked_circle,
              !(_page == 1) ? Colors.black : Colors.green[800]),
          _icon(CommunityMaterialIcons.shopping,
              !(_page == 2) ? Colors.black : Colors.green[800]),
          _icon(CommunityMaterialIcons.truck_delivery,
              !(_page == 3) ? Colors.black : Colors.green[800]),
          _icon(CommunityMaterialIcons.nature_people,
              !(_page == 4) ? Colors.black : Colors.green[800]),
        ],
        onTap: (index) {
          setState(() {
            _showPage = _pageChooser(index);
            _page = index;
          });
        },
      ),
    );
  }
}

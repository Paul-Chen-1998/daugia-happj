import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/main.dart';
import 'package:flutterhappjapp/pages/DonHang.dart';
import 'package:flutterhappjapp/pages/GioHang.dart';
import 'package:flutterhappjapp/pages/HoSo.dart';
import 'package:flutterhappjapp/pages/HomePage.dart';
import 'package:flutterhappjapp/pages/YeuThich.dart';
import 'package:flutterhappjapp/pages/login_ui/page_main.dart';
import 'package:flutterhappjapp/utils/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
//class Main extends StatelessWidget {
//  AuthFunc auth;
//  VoidCallback onSignedOut;
//  String userId,userEmail;
//
//  Main({this.auth, this.onSignedOut, this.userId, this.userEmail});
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: SwapPage(auth: auth,onSignedOut:onSignedOut ,userEmail: userId,userId: userEmail,),
//    );
//  }
//}

// ignore: must_be_immutable
class Main extends StatefulWidget {
//  AuthFunc auth;
//  VoidCallback onSignedOut;
//  String userId, userEmail;
//
//  Main({Key key, this.auth, this.onSignedOut, this.userId, this.userEmail})
//      : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _page = 0;
  final HomePage _homePage = HomePage();
  final PageDonHang _dauGia = new PageDonHang();
  final GioHang _gioHang = new GioHang();
  final PageYeuThich _donHang = new PageYeuThich();
  final HoSoPage _hoSo = new HoSoPage();

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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isEmailVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _checkEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
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
      ),
    );
  }
//
//  void _checkEmailVerification() async {
//    _isEmailVerified = await widget.auth.isEmailVerified();
//    if (!_isEmailVerified) {
//      _showVerifyEmailDialog();
//    }
//  }
//
//  void _showVerifyEmailDialog() {
//    // ignore: missing_return
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: new Text('Please verify your email'),
//            content:
//                new Text('We need you verify email to continue use this app'),
//            actions: <Widget>[
//              new FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                    //_sendVerifyEmail();
//                  },
//                  child: new Text('Send')),
//              new FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: new Text('Dismiss'))
//            ],
//          );
//        });
//  }

//  void _sendVerifyEmail() {
//    widget.auth.sendEmailVerification();
//    _showVerifyEmailSendDialog();
//  }
//
//  void _showVerifyEmailSendDialog() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: new Text('Thank you'),
//            content: new Text('Link verify has been sent to your email'),
//            actions: <Widget>[
//              new FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: new Text('Ok'))
//            ],
//          );
//        });
//  }
//
//  void _signOut() async {
//    try {
//      await widget.auth.signOut();
//      widget.onSignedOut();
//    } catch (e) {
//      print(e);
//    }
//  }
}

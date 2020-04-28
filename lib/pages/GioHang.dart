import 'package:flutter/material.dart';

// import
import 'package:flutterhappjapp/components/ChiTietGioHang.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class GioHang extends StatefulWidget {
  @override
  _GioHangState createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  @override
  Widget build(BuildContext context) {
    Widget _appbar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green, Colors.greenAccent),
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Text(
        "Sản Phẩm Thắng",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 5.0,
        ),
      ),
    );
    Widget _bottomNavigationBar = new Container(
      height: 110,
      decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' Tổng tiền: \n',
                  style: new TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: '360.000 VND',
                  style: new TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          new MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red, width: 2)),
            hoverColor: Colors.green,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
              child: new Text(
                'Thanh toán',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            ),
            color: Colors.white,
          )
        ],
      ),
    );
    return Scaffold(
        appBar: _appbar,
        body: new ChiTietGioHang(),
        bottomNavigationBar: _bottomNavigationBar);
  }
}

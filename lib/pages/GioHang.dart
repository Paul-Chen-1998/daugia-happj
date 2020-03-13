import 'package:flutter/material.dart';
// import
import 'package:flutterhappjapp/components/ChiTietGioHang.dart';
class GioHang extends StatefulWidget {
  @override
  _GioHangState createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Giỏ Hàng"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),

      body: new ChiTietGioHang(),

      bottomNavigationBar: new Container(
        color: Colors.green,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text("Tổng: "),
              subtitle: new Text("370000 \ VND"),
            )),
            Expanded(
              child: new MaterialButton(onPressed: (){},
              child: new Text("Thanh Toán", style: TextStyle(color: Colors.white),),
              color: Colors.red,),
            )
          ],
        ),
      ),
    );
  }
}

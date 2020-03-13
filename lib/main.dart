import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my all import
import 'package:flutterhappjapp/components/Horizontal_Listview.dart';
import 'package:flutterhappjapp/components/Sanpham.dart';
import 'package:flutterhappjapp/pages/GioHang.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/carousel/carousel1.jpg'),
          AssetImage('images/carousel/carousel2.jpg'),
          AssetImage('images/carousel/carousel3.jpg'),
          AssetImage('images/carousel/carousel4.jpg'),
        ],
        autoplay: true,
//        animationCurve: Curves.fastOutSlowIn,
//        animationDuration: Duration(microseconds: 1000),
      dotSize: 4.0,
      dotBgColor: Colors.transparent,
      indicatorBgPadding: 2.0,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Happj App"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new GioHang()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //Header
            new UserAccountsDrawerHeader(
              accountName: Text('Đỗ Xuân Tâm'),
              accountEmail: Text('tamtubi@gmai.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Trang Chủ'),
                leading: Icon(Icons.home,color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Tài Khoản'),
                leading: Icon(Icons.person,color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Đơn Hàng'),
                leading: Icon(Icons.shopping_basket, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => new GioHang()));
              },
              child: ListTile(
                title: Text('Giỏ Hàng'),
                leading: Icon(Icons.shopping_cart, color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Yêu Thích'),
                leading: Icon(Icons.favorite, color: Colors.red),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Cài Đặt'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.green,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Trợ Giúp'),
                leading: Icon(
                  Icons.help,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          //slide chuyển ảnh
          image_carousel,
          //padding widget
          new Padding(
            padding: const EdgeInsets.all(2.0),
            child: new Text('Danh Sách Ngành Hàng'),
          ),
          //Horizontal listview
          HorizontalList(),
          //Padding widget
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text('Sản Phẩm Gần Đây'),
          ),
          //grid view
          Container(
            height:320.0,
            child: Sanpham(),
          )
        ],
      ),
    );
  }
}

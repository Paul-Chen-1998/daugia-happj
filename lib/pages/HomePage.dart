import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/components/Horizontal_Listview.dart';
import 'package:flutterhappjapp/components/Sanpham.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'GioHang.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget _imageCarousel = new Container(
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
    Widget _appBar = new AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.green[700],
      leading: new IconButton(
          icon: Icon(CommunityMaterialIcons.menu,color:Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer()),
      title: Text(
        "HAPPJ APP",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      actions: <Widget>[
        new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: null),
        new IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new GioHang()));
            })
      ],
    );
    Widget _drawer = new Drawer(
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
              leading: Icon(Icons.home, color: Colors.red),
            ),
          ),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Tài Khoản'),
              leading: Icon(Icons.person, color: Colors.red),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new GioHang()));
            },
            child: ListTile(
              title: Text('Giỏ Hàng'),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
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
    );
    Widget _body = new Column(
      children: <Widget>[
        //slide chuyển ảnh
        _imageCarousel,
        //padding widget
        new Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Danh Sách Ngành Hàng',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0),
              )),
        ),
        //Horizontal listview
        HorizontalList(),
        //Padding widget
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Sản Phẩm Gần Đây',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0),
              )),
        ),
        //grid view
        Flexible(child: Sanpham()),
      ],
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      drawer: _drawer,
      body: new ListView(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _body,
          ),
          new SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}

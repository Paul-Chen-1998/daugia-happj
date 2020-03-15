import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:flutterhappjapp/components/Sanpham.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
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
      flexibleSpace: GradientAppbar(Colors.green[800], Colors.white70),
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      leading: new IconButton(
          icon: Icon(CommunityMaterialIcons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer()),
      title: Text(
        "HAPPJ APP",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 10.0,
        ),
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
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Header
          new UserAccountsDrawerHeader(
            accountName: Text('Đỗ Xuân Tâm'),
            accountEmail: Text('tamtubi@gmai.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.green[200],
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.red, Colors.blue]),
            ),
          ),
          new Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              color: Colors.orange,
              height: 350,
              child: new ListView(
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  CustomListTile('Thực phẩm sạch',
                      'images/category/nongsan.png', 30.0, 30.0, () {
                    /* function*/
                  }),
                  CustomListTile('Sức Khỏe-Sắc Đẹp',
                      'images/category/suckhoe.png', 30.0, 30.0, () {}),
                  CustomListTile('Hàng Nhập Khẩu',
                      'images/category/hangnhapkhau.png', 30.0, 30.0, () {}),
                  CustomListTile('Thời Trang', 'images/category/thoitrang.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Du lịch', 'images/category/dulich.png', 30.0,
                      30.0, () {}),
                  CustomListTile('Xây dựng', 'images/category/xaydung.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Điện máy', 'images/category/congnghe.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Bất động sản',
                      'images/category/batdongsan.png', 30.0, 30.0, () {}),
                  CustomListTile('Truyền nghề',
                      'images/category/truyennghe.png', 30.0, 30.0, () {}),
                  CustomListTile('Công việc', 'images/category/congviec.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Bảo hiểm', 'images/category/baohiem.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Quà tặng', 'images/category/quatang.png',
                      30.0, 30.0, () {}),
                ],
              )),

          Divider(
            thickness: 1.5,
            color: Colors.black,
          ),

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

class CustomListTile extends StatelessWidget {
  final String text;
  final String hinhAnh;
  final double sizeImageWidth;
  final double sizeImageHeight;
  Function onTap;

  CustomListTile(this.text, this.hinhAnh, this.sizeImageWidth,
      this.sizeImageHeight, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(0.0),
      child: new Material(
        child: new InkWell(
          splashColor: Colors.green,
          onTap: onTap,
          child: ListTile(
            title: Text(
              text,
              style: new TextStyle(fontSize: 17.0),
            ),
            leading: new Image.asset(hinhAnh,
                fit: BoxFit.cover,
                width: sizeImageWidth,
                height: sizeImageHeight),
            trailing: Icon(CommunityMaterialIcons.chevron_right),
          ),
        ),
      ),
    );
  }
}

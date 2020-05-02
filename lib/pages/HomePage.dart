import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutterhappjapp/pages/ChiTietSanPham.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:flutterhappjapp/utils/auth_service.dart';
import 'package:flutterhappjapp/utils/provider.dart';
import 'GioHang.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List data;

  Future<List> getData() async {
    try {
      final response = await http.get(Server.getAllProduct);
//      var jsonResponse = json.decode(response.body);
//      data = jsonResponse.map((Map model)=> Product.fromJson(model)).toList();
      var a = json.decode(response.body);
      return a['data'];
    } catch (e) {
      print(e);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _appBar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green, Colors.greenAccent),
      brightness: Brightness.dark,
      backgroundColor: Colors.greenAccent,
      leading: new IconButton(
          icon: Icon(CommunityMaterialIcons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer()),
      title: Text(
        "Auction App",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black,
          letterSpacing: 10.0,

        ),
      ),
      centerTitle: true,
    );
    Widget _drawer = new Drawer(
      child: new ListView(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Header
          new UserAccountsDrawerHeader(
            accountName: Text('Nguyễn Thế Vinh'),
            accountEmail: Text('VinhVatVo@gmail.com'),
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
                  CustomListTile('Hàng Nhập Khẩu',
                      'images/category/hangnhapkhau.png', 30.0, 30.0, () {}),
                  CustomListTile('Thời Trang', 'images/category/thoitrang.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Điện máy', 'images/category/congnghe.png',
                      30.0, 30.0, () {}),
                  CustomListTile('Bất động sản',
                      'images/category/batdongsan.png', 30.0, 30.0, () {}),
                  CustomListTile('Xe Cộ',
                      'images/category/xeco.png', 30.0, 30.0, () {}),
                  CustomListTile('Khác',
                      'images/category/khac.png', 30.0, 30.0, () {}),
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
    Widget _body = new ListView(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          height: 800,
          child: new Column(
            children: <Widget>[
              //padding widget
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      'Tất Cả Sản Phẩm',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0),
                    )),
              ),
              //grid view
              new FutureBuilder<List>(
                future: getData(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? Flexible(child: Sanpham(list: snapshot.data))
                      : new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 550,
                          child: new Center(
                            child: new CircularProgressIndicator(),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      drawer: _drawer,
      body: _body
    );
  }
}

class Sanpham extends StatefulWidget {
  final List list;

  Sanpham({this.list});

  @override
  _SanphamState createState() => _SanphamState();
}

class _SanphamState extends State<Sanpham> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 550,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.list.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemBuilder: (BuildContext context, int index) {
            return Sanpham_don(
              ten_sp: widget.list[index]['nameProduct'],
              hinh_sp: widget.list[index]['imageProduct'],
              gia_sp_moi: widget.list[index]['startPriceProduct'],
              idProduct: widget.list[index]['_id'],
            );
          }),
    );
  }
}

class Sanpham_don extends StatelessWidget {
  final ten_sp;
  final List hinh_sp;
  final gia_sp_moi;
  final idProduct;

  Sanpham_don({this.ten_sp, this.hinh_sp, this.gia_sp_moi, this.idProduct});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: '$idProduct' + ten_sp,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                //sanpham = > chi tiet san pham
                builder: (context) => new chitietsanpham(
                  idProduct: idProduct,
                ),
              ),
            ),
            child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          ten_sp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      new Text(
                        "${gia_sp_moi} \ VND",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
//                child: Image.asset(
//                  hinh_sp,
//                  fit: BoxFit.cover,
//                ),
                child: Image.network(Server.hinhAnh + hinh_sp[0],
//                "http://localhost:3000/uploads/1585651533101zzzz.jpg",
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
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
              style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
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

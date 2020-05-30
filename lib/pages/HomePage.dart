import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/ChiTietSanPham.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:flutterhappjapp/utils/auth_service.dart';
import 'package:flutterhappjapp/utils/provider.dart';
import 'package:time_formatter/time_formatter.dart';
import 'SanPhamThang.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Product> listData = new List();
  List list;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    this.getData();
  }

  _onEntryAdded(Event event) {
    setState(() {
      listData.add(Product.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = listData.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    Map a = event.snapshot.value;
    setState(() {
      listData[listData.indexOf(old)] =
          Product.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _appBar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
      brightness: Brightness.dark,
      backgroundColor: Colors.greenAccent,
//      leading: new IconButton(
//          icon: Icon(CommunityMaterialIcons.menu, color: Colors.black),
//          onPressed: () => _scaffoldKey.currentState.openDrawer()),
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
//      actions: <Widget>[
//        new IconButton(
//            icon: Icon(
//              Icons.check_circle,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => new SanPhamThang()));
//            })
//      ],
    );
//    Widget _drawer = new Drawer(
//      child: new ListView(
////        mainAxisSize: MainAxisSize.min,
////        crossAxisAlignment: CrossAxisAlignment.start,
////        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          //Header
//          new UserAccountsDrawerHeader(
//            accountName: Text('Nguyễn Thế Vinh'),
//            accountEmail: Text('VinhVatVo@gmail.com'),
//            currentAccountPicture: GestureDetector(
//              child: new CircleAvatar(
//                backgroundColor: Colors.green[200],
//                child: Icon(
//                  Icons.person,
//                  color: Colors.white,
//                ),
//              ),
//            ),
//            decoration: new BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: <Color>[Colors.red, Colors.blue]),
//            ),
//          ),
//          new Container(
//              margin: EdgeInsets.all(0.0),
//              padding: EdgeInsets.all(0.0),
//              color: Colors.orange,
//              height: 350,
//              child: new ListView(
//                padding: EdgeInsets.all(0.0),
//                children: <Widget>[
//                  CustomListTile('Thực phẩm sạch',
//                      'images/category/nongsan.png', 30.0, 30.0, () {
//                    /* function*/
//                  }),
//                  CustomListTile('Hàng Nhập Khẩu',
//                      'images/category/hangnhapkhau.png', 30.0, 30.0, () {}),
//                  CustomListTile('Thời Trang', 'images/category/thoitrang.png',
//                      30.0, 30.0, () {}),
//                  CustomListTile('Điện máy', 'images/category/congnghe.png',
//                      30.0, 30.0, () {}),
//                  CustomListTile('Bất động sản',
//                      'images/category/batdongsan.png', 30.0, 30.0, () {}),
//                  CustomListTile('Xe Cộ',
//                      'images/category/xeco.png', 30.0, 30.0, () {}),
//                  CustomListTile('Khác',
//                      'images/category/khac.png', 30.0, 30.0, () {}),
//                ],
//              )),
//
//          Divider(
//            thickness: 1.5,
//            color: Colors.black,
//          ),
//
//          InkWell(
//            onTap: () {},
//            child: ListTile(
//              title: Text('Cài Đặt'),
//              leading: Icon(
//                Icons.settings,
//                color: Colors.green,
//              ),
//            ),
//          ),
//
//          InkWell(
//            onTap: () {},
//            child: ListTile(
//              title: Text('Trợ Giúp'),
//              leading: Icon(
//                Icons.help,
//                color: Colors.blue,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
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
              new StreamBuilder(
                stream: itemRef.onValue,
                // ignore: missing_return
                builder: (context, snap) {
                  if (snap.hasError) {
                    print("has error");
                    print(snap.error);
                  }
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                     listData.clear();
                    print('begin homepage');
                    Map data = snap.data.snapshot.value;
                    data.forEach((index, data) {
                      listData.add(Product(
                          winner: data['winner'],
                          name: data['nameProduct'],
                          userId: data['userId'],
                          startPrice: data['startPriceProduct'],
                          registerDate: data['registerDate'],
                          nameType: data['nameProductType'],
                          img: data['imageProduct'],
                          description: data['description'],
                          extraTime: data['extraTime'],
                          status: data['status'],
                          key: index));
                    });
                    return Flexible(child: Sanpham(list: listData));
                  } else
                    return new Container(
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
//      drawer: _drawer,
      body: _body,
    );
  }
}

class Sanpham extends StatefulWidget {
  final List<Product> list;

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
              ten_sp: widget.list[index].name,
              hinh_sp: widget.list[index].img,
              gia_sp_moi: widget.list[index].startPrice,
              idProduct: widget.list[index].key,
              extraTime: widget.list[index].extraTime,
              winner: widget.list[index].winner,
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
  final extraTime;
  final List winner;
  Sanpham_don({this.ten_sp, this.hinh_sp, this.gia_sp_moi, this.idProduct,this.extraTime,this.winner});

  String _printDuration(String mili) {
    var duration = new Duration(milliseconds: int.parse(mili));
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
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
                        child: Text(
                          ten_sp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Image.asset('images/miniicon/minibid.png'),
                              new Text(
                                "${gia_sp_moi} \ VND",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              if (int.parse(extraTime) -
                                  DateTime.now()
                                      .millisecondsSinceEpoch >
                                  0) ...[
                                CountdownTimer(
                                  endTime:
                                  int.parse(extraTime),
                                  hoursSymbolTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  minSymbolTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  secSymbolTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  hoursSymbol: ":",
                                  minSymbol: ": ",
                                  secSymbol: ":",
                                  hoursTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  minTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  secTextStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                  onEnd: () {
                                    print('successful');
                                  },
                                ),
                              ] else ...[
                                Text("Đã kết thúc"),
                              ]
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset('images/miniicon/miniuser.png'),
                              new Text(
                                winner[0] ,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                        ],
                      )
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

class CustomBarWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: 160.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Positioned(
              top: 80.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                          _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

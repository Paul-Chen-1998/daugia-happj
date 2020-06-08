import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/ChiTietSanPham.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';


import 'User/DiaChi.dart';

class Option extends StatefulWidget {
  String theLoai;

  Option({this.theLoai});

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
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
    //var a = itemRef.onChildAdded.listen(_onEntryAdded);
    //var b = itemRef.onChildChanged.listen(_onEntryChanged);
    this.getData();
  }

  @override
  void dispose() {
    super.dispose();
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
      listData[listData.indexOf(old)] = Product.fromSnapshot(event.snapshot);
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
              new StreamBuilder(
                stream: itemRef.orderByChild("nameProductType").equalTo(widget.theLoai).onValue,
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print("has error");
                    print(snapshot.error);
                  }
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    listData.clear();
                    print('begin homepage');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      listData.add(Product(
                          currentPrice: data['currentPrice'],
                          hide: data['hide'],
                          played: data['played'],
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
                    return Flexible(child: Sanpham(list: listData,s: "Chưa có sản phẩm nào được đấu giá!",));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 550,
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (!snapshot.hasError &&
                      snapshot.data.snapshot.value == null) {
                    return Text('Chưa có sản phẩm nào đang được đấu giá!',
                        style: TextStyle(color: Colors.black, fontSize: 25.0));
                  }
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

  outputMoney(var money) {
    return "${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
      symbol: 'VND',
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' ',
      fractionDigits: 0,
    ), amount: double.parse(money)).output.symbolOnRight}";
  }
}

class Sanpham extends StatefulWidget {
  final List<Product> list;
  final String s;
  Sanpham({this.list,this.s});

  @override
  _SanphamState createState() => _SanphamState();
}

class _SanphamState extends State<Sanpham> {
  @override
  Widget build(BuildContext context) {
    return widget.list.length != 0
        ? Container(
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
    )
        : Container(padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: 550,
      child: Text(widget.s,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20.0)),
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
  SharedPreferences sharedPreferences;

  Sanpham_don(
      {this.ten_sp,
        this.hinh_sp,
        this.gia_sp_moi,
        this.idProduct,
        this.extraTime,
        this.winner});

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

  outputMoney(var money) {
    return "${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
      symbol: 'VND',
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' ',
      fractionDigits: 0,
    ), amount: double.parse(money)).output.symbolOnRight}";
  }

  Future<dynamic> getAddress() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String id = sharedPreferences.getString('_id');
      String url = Server.getAddress + id;
      final response = await http.get(url);
      var a = json.decode(response.body);
      var c = a['message'];
      print(a);
      return a;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: '$idProduct' + ten_sp,
        child: Material(
          child: InkWell(
            onTap: () {
              if (TrangThai.checkAddress == null) {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    //sanpham = > chi tiet san pham
                      builder: (context) => new SplashPage()),
                );
                getAddress().then((value) {
                  if (value['message']) {
                    TrangThai.checkAddress = value['message'];
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        //sanpham = > chi tiet san pham
                        builder: (context) => new chitietsanpham(
                          idProduct: idProduct,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        //sanpham = > chi tiet san pham
                        builder: (context) => new DiaChi(),
                      ),
                    );
                  }
                });
              } else {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    //sanpham = > chi tiet san pham
                    builder: (context) => new chitietsanpham(
                      idProduct: idProduct,
                    ),
                  ),
                );
              }
            },
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
                                outputMoney(gia_sp_moi),
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
                                  DateTime.now().millisecondsSinceEpoch >
                                  0) ...[
                                CountdownTimer(
                                  endTime: int.parse(extraTime),
                                  hoursSymbolTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  minSymbolTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  secSymbolTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  hoursSymbol: ":",
                                  minSymbol: ": ",
                                  secSymbol: ":",
                                  hoursTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  minTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  secTextStyle: TextStyle(
                                      fontSize: 10, color: Colors.red),
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
                                winner[0],
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

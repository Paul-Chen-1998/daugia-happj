import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'add_product.dart';

class SanPhamCuaToi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Của Tôi",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new AddProducts()));
              })
        ],
      ),
      body: Controller(),
    );
  }
}

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  List<Product> listProduct = new List();
  DatabaseReference itemRef;
  SharedPreferences sharedPreferences;
  String id;

  Future<Null> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String idd = prefs.getString('_id');
    setState(() {
      id = idd;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = "";
    getId();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemRef.orderByChild("userId").equalTo(id).onValue,
      builder: (context, snap) {
        if (snap.hasError) {
          print("has error");
          print(snap.error);
        }
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          listProduct.clear();
          Map data = snap.data.snapshot.value;
          data.forEach((key, data) {
            listProduct.add(Product(
                winner: null,
                name: data['nameProduct'],
                userId: data['userId'],
                startPrice: data['startPriceProduct'],
                registerDate: data['registerDate'],
                nameType: data['nameProductType'],
                img: data['imageProduct'],
                description: data['description'],
                extraTime: data['extraTime'],
                status: data['status'],
                key: key));
          });
          return Sanpham(
            list: listProduct,
          );
        } else {
          return ShimmerProduct();
        }
      },
    );
  }
}

class ShimmerProduct extends StatefulWidget {
  @override
  _ShimmerProductState createState() => _ShimmerProductState();
}

class _ShimmerProductState extends State<ShimmerProduct> {
  bool _enabled = true;

  Widget shimmer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: _enabled,
                child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                              child: Hero(
                            tag: index,
                            child: Material(
                              child: GridTile(
                                footer: Container(
                                    color: Colors.white70,
                                    child: Column(
                                      children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: new Container(
                                                color: Colors.white,
                                                width: 18.0,
                                                height: 18.0,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'images/miniicon/minibid.png'),
                                                    new Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.0),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'images/miniicon/miniclock.png'),
                                                    new Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.0),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'images/miniicon/miniuser.png'),
                                                    new Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.0),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                child: Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )));
                    })),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return shimmer();
  }
}

class Sanpham extends StatefulWidget {
  List<Product> list;

  Sanpham({this.list});

  @override
  _SanphamState createState() => _SanphamState();
}

class _SanphamState extends State<Sanpham> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      color: Colors.orangeAccent,
      child: GridView.builder(
          itemCount: widget.list.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Sanpham_don(
                product: widget.list[index],
                index: index,
              ),
            );
          }),
    );
  }
}

class Sanpham_don extends StatelessWidget {
  final Product product;
  final index;

  Sanpham_don({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
      tag: index,
      child: Material(
        child: GridTile(
            footer: Container(
                color: Colors.white70,
                child: Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('images/miniicon/minibid.png'),
                                new Text(
                                  "   ${product.startPrice} \ VND",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset('images/miniicon/miniclock.png'),
                                if(int.parse(product.extraTime) - DateTime.now().millisecondsSinceEpoch > 0)...[
                                  CountdownTimer(
                                    endTime: int.parse(product.extraTime),
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
                                ]else ...[
                                  Text("Đã kết thúc"),
                                ]
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset('images/miniicon/miniuser.png'),
                                new Text(
                                  "Chưa có",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            child: Image.network(Server.hinhAnh + product.img[0],
                fit: BoxFit.cover)),
      ),
    ));
  }

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
}

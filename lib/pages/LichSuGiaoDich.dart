import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/Chat.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'User/updateproduct.dart';

class LichSuGiaoDich extends StatefulWidget {
  @override
  _LichSuGiaoDichState createState() => _LichSuGiaoDichState();
}

class _LichSuGiaoDichState extends State<LichSuGiaoDich> {
  DatabaseReference itemRef;
  String idUser;
  List<Product> listData = new List();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //name = sharedPreferences.getString('name');
    setState(() {
      idUser = sharedPreferences.getString('_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idUser = "";
    getNameAndID();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
  }

  @override
  Widget build(BuildContext context) {
    Widget _appbar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
      brightness: Brightness.dark,
      backgroundColor: Colors.greenAccent,
      centerTitle: true,
      title: Text(
        "Lịch Sử Giao Dịch",
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 5.0,
        ),
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
              //grid view
              new StreamBuilder(
                stream: itemRef.orderByChild("hide").equalTo(false).onValue,
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
                    print('begin lich su giao dich');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      if ((DateTime.now().millisecondsSinceEpoch -
                              int.parse(data['extraTime']) >
                          0)) {
                        var useridd = data['userId'];
                        if (useridd.toString() == idUser) {
                          listData.add(Product(
                              currentPrice: data['currentPrice'],
                              hide: data['hide'],
                              winner: data['winner'],
                              name: data['nameProduct'],
                              userId: data['userId'],
                              played: data['played'],
                              startPrice: data['startPriceProduct'],
                              registerDate: data['registerDate'],
                              nameType: data['nameProductType'],
                              img: data['imageProduct'],
                              description: data['description'],
                              extraTime: data['extraTime'],
                              status: data['status'],
                              message: data['message'],
                              key: index));
                        }
                      }
                    });

                    return Flexible(
                        child: ChiTietGiaoDich(
                      product: listData,
                      s: "Bạn chưa có sản phẩm nào!",
                    ));
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
                    return Text('Chưa có sản phẩm nào!',
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
      appBar: _appbar,
      body: _body,
    );
  }
}

class ChiTietGiaoDich extends StatefulWidget {
  List<Product> product;
  String s;

  ChiTietGiaoDich({this.product, this.s});

  @override
  _ChiTietGiaoDichState createState() => _ChiTietGiaoDichState();
}

class _ChiTietGiaoDichState extends State<ChiTietGiaoDich> {
  @override
  Widget build(BuildContext context) {
    return widget.product.length != 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 600.0,
            padding: EdgeInsets.all(8.0),
            child: new ListView.builder(
                itemCount: widget.product.length,
                itemBuilder: (context, index) {
                  return SP_Don_Giao_Dich(
                    product: widget.product[index],
                  );
                }),
          )
        : Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            height: 550,
            child: Text(widget.s,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0)),
          );
  }
}

class SP_Don_Giao_Dich extends StatefulWidget {
  Product product;

  SP_Don_Giao_Dich({this.product});

  @override
  _SP_Don_Giao_DichState createState() => _SP_Don_Giao_DichState();
}

class _SP_Don_Giao_DichState extends State<SP_Don_Giao_Dich> {
  DatabaseReference itemRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
    //this.getData();
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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 200,
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.grey[400],
            blurRadius: 50.0,
          ),
        ]),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Card(
              borderOnForeground: true,
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Controll(
                              keyy: widget.product.key,
                            ))),
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.network(Server.hinhAnh + widget.product.img[0],
                              width: 160.0, height: 250.0, fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "${widget.product.name}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Text(
                          "Giá giao dịch: ${outputMoney(widget.product.startPrice)}",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        new Text(
                          "Giao dịch lúc: *****",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        new Text(
                          "Vai trò: Người mua",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        if (widget.product.winner[1] == "1") ...[
                          new Text(
                            "Sản phẩm chưa có ai đấu giá",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ] else ...[
                          new Text(
                            "Tên đối tác: ${widget.product.winner[0]}",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                        new SizedBox(
                          height: 10,
                        ),
                        new Text(
                          "Xác nhận Giao Dịch",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (widget.product.winner[1] == "1") ...[
                              ButtonTheme(
                                  minWidth: 130.0,
                                  height: 50.0,
                                  child: RaisedButton.icon(
                                      onPressed: () =>
                                          _singleButtonAlterDialogg(context),
                                      icon: Text('Đăng lại'),
                                      label:
                                          Icon(CommunityMaterialIcons.check))),
                              new SizedBox(height: 5),
                              ButtonTheme(
                                  minWidth: 136.0,
                                  height: 50.0,
                                  child: RaisedButton.icon(
                                      onPressed: () =>
                                          _singleButtonAlterDialogg(context),
                                      icon: Text('Xóa'),
                                      label:
                                          Icon(CommunityMaterialIcons.eraser))),
                            ] else ...[
                              ButtonTheme(
                                  minWidth: 130.0,
                                  height: 50.0,
                                  child: RaisedButton.icon(
                                      onPressed: () =>
                                          _singleButtonAlterDialog(context),
                                      icon: Text('Thành Công'),
                                      label:
                                          Icon(CommunityMaterialIcons.check))),
                              new SizedBox(
                                height: 5,
                              ),
                              ButtonTheme(
                                  minWidth: 136.0,
                                  height: 50.0,
                                  child: RaisedButton.icon(
                                      onPressed: () =>
                                          _singleButtonAlterDialogg(context),
                                      icon: Text('Thất Bại'),
                                      label:
                                          Icon(CommunityMaterialIcons.eraser))),
                            ],
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ButtonTheme(
                child: RaisedButton.icon(
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Controll(
                                keyy: widget.product.key,
                              )));
                    },
                    icon: Text(
                      'Chat',
                      style: TextStyle(color: Colors.black),
                    ),
                    label: Icon(
                      CommunityMaterialIcons.chat,
                      color: Colors.black,
                    )))
          ],
        ));
  }

  Future<void> _singleButtonAlterDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return NetworkGiffyDialog(
            key: Key("NetworkDialog"),
            image: Image.network(
              Server.hinhAnh + widget.product.img[0],
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.BOTTOM,
            title: Text(
              "${widget.product.name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
            description: Text("Bạn có chắc đã giao dịch thành công?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                )),
            onOkButtonPressed: () {
              Navigator.of(context).pop();
              XuLyThanhCong();
            },
          );
        });
  }

  Future<void> _singleButtonAlterDialogg(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return NetworkGiffyDialog(
            key: Key("NetworkDialog"),
            image: Image.network(
              Server.hinhAnh + widget.product.img[0],
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.BOTTOM,
            title: Text(
              "${widget.product.name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
            description:
                Text("Bạn có muốn đăng lại sản phẩm?\nCancel để xóa sản phẩm.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
            onOkButtonPressed: () {
              Navigator.of(context).pop();
              XuLyThatBai();
            },
            onCancelButtonPressed: () {
              itemRef.child(widget.product.key.toString()).update({
                "hide" : true,
                "failure" : true
              });
              Navigator.of(context).pop();
            },
          );
        });
  }
  submitNewUyTin(String id) async{
    try{
      String url = Server.updateUyTin + id ;
      var response = await http.put(url);
    }catch(e){
      print(e);

    }

  }

  submitCongUyTin(String id) async{
    try{
      String url = Server.updateCongUyTin + id ;
      var response = await http.put(url);
    }catch(e){
      print(e);

    }

  }
  XuLyThatBai() {
    try {
      if(widget.product.winner[1] == "1"){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Update(
              keyy: widget.product.key.toString(),
            )));
      }else{
        submitNewUyTin(widget.product.winner[1]);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Update(
              keyy: widget.product.key.toString(),
            )));
      }

    } catch (e) {
      print(e);
    }
  }

  XuLyThanhCong() {
    try {
      submitCongUyTin(widget.product.winner[1]);
      print('begin xu ly thanh cong');
      itemRef
          .child(widget.product.key.toString())
          .update({"hide": true, "failure" : false}).then((_) {
        Fluttertoast.showToast(msg: "Success");
      });
    } catch (e) {
      print(e);
    }
  }
}

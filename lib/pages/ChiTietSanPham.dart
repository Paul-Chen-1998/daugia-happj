import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:http/http.dart' as http;
import 'DetailImage.dart';

class chitietsanpham extends StatefulWidget {
  final idProduct;

  chitietsanpham({this.idProduct});

  @override
  _chitietsanphamState createState() => _chitietsanphamState();
}

class _chitietsanphamState extends State<chitietsanpham> {
  DatabaseReference itemRef;
  Product product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database
        .reference()
        .child('products');
    //this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
          brightness: Brightness.dark,
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text(
            "Chi Tiết Sản Phẩm",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 5.0,
            ),
          ),
        ),
        body: new StreamBuilder(
            stream: itemRef.orderByKey().equalTo(widget.idProduct.toString()).onValue,
            // ignore: missing_return
            builder: (context,AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                print('begin detail product');
                DataSnapshot dataValues = snapshot.data.snapshot;
                product = null;
                Map<dynamic, dynamic> data = dataValues.value;
                data.forEach((key,data){
                  product = Product(
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
                      key: key);
                });
                return ListView(
                  children: <Widget>[
                    new Container(
                      height: 300.0,
                      child: GridTile(
                        child: Container(
                          color: Colors.white,
                          child: new Carousel(
                            boxFit: BoxFit.cover,
                            images: product.img.map((img) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Image.network(
                                      Server.hinhAnh + img,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            autoplay: false,
                            onImageTap: (index) {
                              openImageOnScreen(
                                  product.img[index]);
                            },
                            dotSize: 4.0,
                            dotBgColor: Colors.transparent,
                            indicatorBgPadding: 2.0,
                          ),
                        ),
                        footer: new Container(
                          color: Colors.white70,
                          child: ListTile(
                            leading: new Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Image.asset('images/miniicon/minibid.png'),
                                    Expanded(
                                      child: Text(
                                        "${product.startPrice} \ VND  ",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    Image.asset(
                                        'images/miniicon/miniclock.png'),
                                    Expanded(
                                      child: Text(
                                        product.extraTime,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    Image.asset('images/miniicon/miniuser.png'),
                                    Expanded(
                                      child: Text(
                                        " Vinh Vinh",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(context: null);
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 0.2,
                            child: new Text(("Xác Nhận")),
                          ),
                        ),
                      ],
                    ),
                    new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Nhập số tiền bạn muốn đấu (VND)'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                    new ListTile(
                      title: new Text(
                        product.status,
                        style: TextStyle(color: Colors.green),
                      ),
                      subtitle: new Text(product.description),
                    ),
                    Divider(color: Colors.red),
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text(
                            "Tên Sản Phẩm:",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new Text(product.name),
                        )
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text(
                            "Thể loại",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new Text(
                            product.nameType,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text(
                            "Người giữ giá cao nhất hiện tại:",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new Text("Vinh Vật Vờ"),
                        )
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text(
                            "Yêu cầu uy tín:",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new Text(""),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                  ],
                );
              } else {
                return SplashPage();
              }
            }));
  }

  void openImageOnScreen(String urlImage) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDetail(
          hinhAnh: urlImage,
        ),
      ),
    );
  }

  Future getData() async {
    try {
      final response =
          await http.get(Server.getDetailProduct + widget.idProduct);
      var jsonResponse = json.decode(response.body);
      print("_id : " + widget.idProduct);
      return jsonResponse;
    } catch (e) {
      print(e);
    }
  }

  String returnTypeProduct(String _idProductType) {
    String type;
    if (_idProductType == "5ea69cae18de79407cce3e57")
      type = "Thực phẩm sạch";
    else if (_idProductType == "5ea69d27bf173b2170f6b393")
      type = "Hàng nhập khẩu";
    else if (_idProductType == "5ea69d2ebf173b2170f6b394")
      type = "Thời trang";
    else if (_idProductType == "5ea69d39bf173b2170f6b395")
      type = "Điện máy";
    else if (_idProductType == "5ea69d3fbf173b2170f6b396")
      type = "Bất động sản";
    else
      type = "Xe cộ";
    return type;
  }
}

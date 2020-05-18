
import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
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
        body: new FutureBuilder(
            future: getData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData
                  ? ListView(
                      children: <Widget>[
                        new Container(
                          height: 300.0,
                          child: GridTile(
                            child: Container(
                              color: Colors.white,
                              child: new Carousel(
                                boxFit: BoxFit.cover,
                                images:
                                    snapshot.data['imageProduct'].map((img) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      snapshot.data['imageProduct'][index]);
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
                                  snapshot.data['nameProduct'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        Image.asset('images/miniicon/minibid.png'),
                                        Expanded(
                                          child: Text(
                                            "${snapshot.data['startPriceProduct']} \ VND  ",
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
                                        Image.asset('images/miniicon/miniclock.png'),
                                        Expanded(
                                          child: Text(
                                            "  3:00",
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
                                            "   Vinh Vinh",
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
                            snapshot.data['status'],
                            style: TextStyle(color: Colors.green),
                          ),
                          subtitle: new Text(snapshot.data['description']),
                        ),
                        Divider(color: Colors.red),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
                              child: new Text(
                                "Tên Sản Phẩm:",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new Text(snapshot.data['nameProduct']),
                            )
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
                              child: new Text(
                                "Thể loại",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new Text(
                                returnTypeProduct(
                                    snapshot.data['idProductType']),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
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
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
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
                    )
                  : SplashPage();
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
      final response = await http.get(Server.getDetailProduct + widget.idProduct);
      var jsonResponse = json.decode(response.body);
      print("_id : " + widget.idProduct);
      return jsonResponse;
    } catch (e) {
      print(e);
    }
  }

  String returnTypeProduct(String _idProductType) {
    String type;
    if(_idProductType == "5ea69cae18de79407cce3e57")
      type = "Thực phẩm sạch";
    else if (_idProductType== "5ea69d27bf173b2170f6b393")
      type = "Hàng nhập khẩu";
    else if (_idProductType== "5ea69d2ebf173b2170f6b394")
      type = "Thời trang";
    else if (_idProductType== "5ea69d39bf173b2170f6b395")
      type = "Điện máy";
    else if(_idProductType== "5ea69d3fbf173b2170f6b396")
      type = "Bất động sản";
    else
      type = "Xe cộ";
    return type;
  }
}

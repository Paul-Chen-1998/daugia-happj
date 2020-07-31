import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:moneytextformfield/moneytextformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool disableButton = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool load = false;
  String name, idUser,uytin;
  TextEditingController controller = new TextEditingController();

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name');
    idUser = sharedPreferences.getString('_id');
    uytin = sharedPreferences.getString('uytin');
  }
  var fcmtoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
      fcmtoken = deviceToken;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = "";
    idUser = "";
    getNameAndID();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
    //this.getData();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
        body: load
            ? SplashPage()
            : new StreamBuilder(
                stream: itemRef
                    .orderByKey()
                    .equalTo(widget.idProduct.toString())
                    .onValue,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<Event> snapshot) {
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
                    data.forEach((key, data) {
                      product = Product(
                          currentPrice: data['currentPrice'],
                          hide: data['hide'],
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
                          played: data['played'],
                          uyTin: data['uyTin'],
                          fcms: data['fcms'],
                          key: key);
                    });
                    if (int.parse(product.extraTime) -
                            DateTime.now().millisecondsSinceEpoch <
                        0) {
                      disableButton = true;
                    } else {
                      disableButton = false;
                    }
                    TextStyle _ts = TextStyle(fontSize: 26.0);
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
                                  openImageOnScreen(product.img[index]);
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        Image.asset(
                                            'images/miniicon/minibid.png'),
                                        Expanded(
                                          child: Text(
                                            outputMoney(product.startPrice),
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
                                        if (int.parse(product.extraTime) -
                                                DateTime.now()
                                                    .millisecondsSinceEpoch >
                                            0) ...[
                                          CountdownTimer(
                                            endTime:
                                                int.parse(product.extraTime),
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
                                              setState(() {
                                                disableButton = true;
                                              });
                                              _nAlterDialog(context);
                                              setState(() {

                                              });
                                            },
                                          ),
                                        ] else ...[
                                          Text("Đã kết thúc"),
                                        ]
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Image.asset(
                                            'images/miniicon/miniuser.png'),
                                        Expanded(
                                          child: Text(
                                            product.winner[0],
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
                                onPressed: () => disableButton
                                    ? showSnackBar("Đã hết phiên đấu giá",
                                        scaffoldKey, Colors.red[400])
                                    : (_validateInputs()
                                        ? _singleButtonAlterDialog(context)
                                        : null),
                                color: Colors.red,
                                textColor: Colors.white,
                                elevation: 0.2,
                                child: new Text(("Xác Nhận")),
                              ),
                            ),
                          ],
                        ),
                        new Form(
                          child: MoneyTextFormField(
                            settings: MoneyTextFormFieldSettings(
                              enabled: !disableButton,
                              validator: inputMoney,
                              controller: controller,
                              appearanceSettings: AppearanceSettings(
                                padding: EdgeInsets.all(15.0),
                                labelText: 'Nhập số tiền bạn muốn đấu (VND)',
                                hintText: 'Example: 1000',
                                labelStyle: _ts,
                                inputStyle: _ts.copyWith(color: Colors.orange),
                                formattedStyle:
                                    _ts.copyWith(color: Colors.blue),
                              ),
                              moneyFormatSettings: MoneyFormatSettings(
                                  fractionDigits: 0,
                                  currencySymbol: 'VND',
                                  displayFormat:
                                      MoneyDisplayFormat.symbolOnRight),
                            ),
                          ),
                          key: _formKey,
                          autovalidate: _autoValidate,
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
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
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
                                product.nameType,
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
                                "Giá khởi điểm",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new Text(
                                FlutterMoneyFormatter(
                                        settings: MoneyFormatterSettings(
                                          symbol: 'VND',
                                          thousandSeparator: '.',
                                          decimalSeparator: ',',
                                          symbolAndNumberSeparator: ' ',
                                          fractionDigits: 0,
                                        ),
                                        amount:
                                            double.parse(product.currentPrice))
                                    .output
                                    .symbolOnRight,
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
                                "Giá hiện tại",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new Text(
                                FlutterMoneyFormatter(
                                        settings: MoneyFormatterSettings(
                                          symbol: 'VND',
                                          thousandSeparator: '.',
                                          decimalSeparator: ',',
                                          symbolAndNumberSeparator: ' ',
                                          fractionDigits: 0,
                                        ),
                                        amount:
                                            double.parse(product.startPrice))
                                    .output
                                    .symbolOnRight,
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
                              child: new Text(product.winner[0]),
                            )
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 5.0, 5.0),
                              child: new Text(
                                "Người thắng cuộc:",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new Text(product.winner[0]),
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
                              child: new Text("" + product.uyTin),
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

  String inputMoney(String value) {
    if(int.parse(product.uyTin) > int.parse(uytin)){
      return "Không đủ điểm uy tín để đấu giá";
    }
    if (value.isEmpty) {
      return 'Không được nhập chuỗi';
    } else if (double.tryParse(value) == null) {
      return 'Hãy nhập số tiền';
    } else if (double.tryParse(value) < 1000) {
      return 'Số tiền không được bé hơn 1000';
    } else if (double.parse(value) % 1000 != 0) {
      return 'Số tiền phải chia hết cho 1000';
    } else if (double.parse(controller.text.trim()) <=
        double.parse(product.startPrice)) {
      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
          settings: MoneyFormatterSettings(
            symbol: 'VND',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 0,
          ),
          amount: double.parse(product.startPrice));
      return 'Số tiền phải lớn hơn số tiền đang được đấu giá ( ${fmf.output.symbolOnRight} )';
    }else if(double.parse(controller.text.trim()) >
        double.parse(product.startPrice) * 2){

      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
          settings: MoneyFormatterSettings(
            symbol: 'VND',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 0,
          ),
          amount: double.parse(product.startPrice));
      return 'Số tiền không được lớn gấp đôi số tiền đang được đấu giá ( ${fmf.output.symbolOnRight} )';
    }
    return null;
  }

  _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      return true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
      return false;
    }
  }
   outputMoney(var money){
    return  "${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
      symbol: 'VND',
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' ',
      fractionDigits: 0,
    ), amount: double.parse(money)).output.symbolOnRight}";
  }
  Future<void> _singleButtonAlterDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return NetworkGiffyDialog(
            key: Key("NetworkDialog"),
            image: Image.network(
              Server.hinhAnh + product.img[0],
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.BOTTOM,
            title: Text(
              "${product.name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
            description: Text(
                "Bạn có muốn đấu giá?\nSố tiền đấu giá của bạn là: ${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                      symbol: 'VND',
                      thousandSeparator: '.',
                      decimalSeparator: ',',
                      symbolAndNumberSeparator: ' ',
                      fractionDigits: 0,
                    ), amount: double.parse(controller.text)).output.symbolOnRight}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                )),
            onOkButtonPressed: () {
              Navigator.of(context).pop();
              XuLyDauGia();
            },
          );
        });
  }

  XuLyDauGia() async {
    try {
      setState(() {
        load = true;
      });
      double moneyWinner = double.parse(controller.text);

      List winner = new List();
      winner.add(name);
      winner.add(idUser);

      List played = new List();
      played.addAll(product.played);
      bool check = false;
      for(var item in played){
        if(item == idUser.trim().toString()){
          check = true;
          break;
        }
      }
      if(check == false){
        played.add(idUser.trim().toString());
      }

      List fcms = new List();
      fcms.addAll(product.fcms);
      fcms.add(fcmtoken);
      fcms = fcms.reversed.toList();
      fcms = fcms.toSet().toList();
      fcms = fcms.reversed.toList();

      itemRef.child(widget.idProduct.toString()).update({
        "startPriceProduct": moneyWinner.toString(),
        "winner": winner,
        "idWinner" : idUser,
        "played" : played,
        "fcms" : fcms
      }).then((_) {
        showSnackBar(
            'Bạn đang đứng đầu phiên đấu giá', scaffoldKey, Colors.green[700]);
        winner.clear();
        played.clear();
        fcms.clear();
      });
      setState(() {
        load = false;
      });
    } catch (e) {
      setState(() {
        load = false;
      });
      showSnackBar('Lỗi phát sinh khi đấu giá', scaffoldKey, Colors.red[400]);
      print(e);
    }
  }
  Future<void> _nAlterDialog(BuildContext context) {
    String name = "Bạn";
    if(idUser != product.winner[1]){
      name = product.winner[0];
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chào mừng bạn đến với Auction app!!'),
          content:  Text(
              "$name đã thắng phiên đấu giá với số tiền: ${outputMoney(product.startPrice)}"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  showSnackBar(String message, final scaffoldKey, Color color) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: new TextStyle(color: Colors.white),
      ),
    ));
  }
}

import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
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
  bool disableButton = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool load = false;
  String name,idUser;
  TextEditingController controller = new TextEditingController();
  getNameAndID() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name');
    idUser = sharedPreferences.getString('_id');
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
                          winner: data['winner'] ,
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
                    if (int.parse(product.extraTime) -
                            DateTime.now().millisecondsSinceEpoch >
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
                                            "${ FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                          symbol: 'VND',
                                            thousandSeparator: '.',
                                            decimalSeparator: ',',
                                            symbolAndNumberSeparator: ' ',
                                            fractionDigits: 0,
                                          ),
                                            amount: double.parse(product.startPrice)
                                        ).output.symbolOnRight}  ",
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
                                              print('successful');
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
                                    ? XuLyDauGia()
                                    : showSnackBar("Đã hết phiên đấu giá",
                                        scaffoldKey, Colors.red[400]),
                                color: Colors.red,
                                textColor: Colors.white,
                                elevation: 0.2,
                                child: new Text(("Xác Nhận")),
                              ),
                            ),
                          ],
                        ),
                        new Form(
                          child:  MoneyTextFormField(
                            settings: MoneyTextFormFieldSettings(
                              enabled: disableButton,
                              validator:inputMoney,
                              controller: controller,
                              appearanceSettings: AppearanceSettings(
                                padding: EdgeInsets.all(15.0),
                                labelText: 'Nhập số tiền bạn muốn đấu (VND)',
                                hintText: 'Example: 1000',
                                labelStyle: _ts,
                                inputStyle: _ts.copyWith(color: Colors.orange),
                                formattedStyle: _ts.copyWith(color: Colors.blue),
                              ),
                              moneyFormatSettings: MoneyFormatSettings(fractionDigits: 0,
                                  currencySymbol: 'VND',
                                  displayFormat:
                                  MoneyDisplayFormat.symbolOnRight),
                            ),
                          ),
//                          new TextFormField(
//                            controller: controller,
//                            decoration: InputDecoration(
//                                contentPadding: EdgeInsets.only(left: 20.0),
//                                labelText: 'Nhập số tiền bạn muốn đấu (VND)'),
//                            textInputAction: TextInputAction.next,
//                            keyboardType: TextInputType.number,
//                            enabled: disableButton,
//                            // ignore: missing_return
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Không được để trống';
//                              } else if (double.tryParse(value) == null) {
//                                return 'Hãy nhập số tiền';
//                              } else {
//                                return null;
//                              }
//                            },
//                          ),
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
  String inputMoney(String value) {
    if (value.isEmpty) {
      return 'Không được nhập chuỗi';
    } else if (double.tryParse(value) == null) {
      return 'Hãy nhập số tiền';
    }else if(double.tryParse(value) < 1000){
      return 'Số tiền không được bé hơn 1000';
    }else if(double.parse(value) % 1000 != 0){
      return 'Số tiền phải chia hết cho 1000';
    }else if(double.parse(controller.text.trim()) < double.parse(product.startPrice)){
      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
      ),
          amount: double.parse(product.startPrice)
      );
      return 'Số tiền phải lớn hơn số tiền đang được đấu giá ( ${fmf.output.symbolOnRight} )';
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

  XuLyDauGia() async{
    if (!_validateInputs()) {
      print('nhap sai du lieu');
      return;
    } else {
      setState(() {
        load = true;
      });
      double moneyWinner = double.parse(controller.text);

      print(name);
      List winner = new List();
      winner.add(name);
      winner.add(idUser);
      itemRef.child(widget.idProduct.toString()).update({
        "startPriceProduct" : moneyWinner.toString(),
        "winner" : winner
       }).then((_){
        showSnackBar('Bạn đang đứng đầu phiên đấu giá', scaffoldKey, Colors.green[700]);
        winner.clear();
        controller = new TextEditingController(text: "");
      });
      setState(() {
        load = false;
      });
    }
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

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historyy extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<Historyy> {
  DatabaseReference itemRef;
  String idUser;
  double tongTien = 0;
  int soLuongWin = 0;
  int soLuongLose = 0;

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //name = sharedPreferences.getString('name');
    setState(() {
      idUser = sharedPreferences.getString('_id');
    });
  }

  getData() {
    itemRef.orderByChild("hide").equalTo(true).once().then((value) {
      Map data = value.value;
      if (data == null) {
        print("chua co sanb pham");
        Fluttertoast.showToast(msg: "Chưa có");
        return;
      }
      data.forEach((index, data) {
        if (data['failure'] == null) {
          print("khong ton tai");
          soLuongWin++;
          tongTien = double.parse(data['startPriceProduct']) + tongTien;
        } else if(data['failure'] == true) {
          soLuongLose++;
        }else if(data['failure'] == false){
          soLuongWin++;
          tongTien = double.parse(data['startPriceProduct']) + tongTien;
        }
      });
      setState(() {});
    });
  }

  outputMoney(var money) {
    return "${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
        ), amount: money).output.symbolOnRight}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
    getNameAndID();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("History"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Số đơn hàng thành công: $soLuongWin",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () => print("text button"),
                        child: Text("Xem chi tiết"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Tổng tiền: ${outputMoney(tongTien)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Số đơn hàng thất bại: $soLuongLose",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () => print("text button"),
                        child: Text("Xem chi tiết"),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}

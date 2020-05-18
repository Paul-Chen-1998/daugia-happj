import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class SanPhamThang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Thắng",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
      body: Sanpham(),
    );
  }
}

class Sanpham extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: Center(
            child: ExpansionCard(
              borderRadius: 20,
              background: Image.asset(
                "images/Sanpham/cacao2.jpg",
                fit: BoxFit.cover,
              ),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tropical CaCao",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Giá Thắng: 150 000",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tên Người Bán: Bảo Bảo",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "Số Điện Thoại: 0363900639",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "Địa chỉ giao dịch: ko có, Phường Cầu Kho, Quận 1, TP Hồ Chí Minh",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),

                )
              ],
            )));
  }
}

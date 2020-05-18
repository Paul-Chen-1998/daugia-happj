import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class TroGiup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainApp());
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
          brightness: Brightness.dark,
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text(
            "Trợ Giúp",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 5.0,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
            children: <Widget>[
              ExpansionCard(
                borderRadius: 20,
                background: Image.asset(
                  "images/anhgif/bid.gif",
                  fit: BoxFit.cover,
                ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Đấu giá",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Bước 1",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: Text("Nhấp chọn thông tin sản phẩm mục tiêu và đưa ra mức giá bạn muốn tham gia, theo dõi thông qua các màn hình (sản phẩm đang thắng/ sản phẩm đang thua), thời gian kết thúc bạn là người trả giá cao nhất thì bạn hãy tiến hành giao dịch",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              ),
              SizedBox(
                  height: 20
              ),
              ExpansionCard(
                borderRadius: 20,
                background: Image.asset(
                  "images/anhgif/trade.gif",
                  fit: BoxFit.cover,
                ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Giao dịch",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Bước 2",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: Text("Thông tin sản phẩm bạn thắng ở Bước 1 sẽ được chuyển về màn hình (Sản phẩm thắng) bạn hoặc chủ nhân của sản phẩm sẽ chủ động liên hệ với nhau để tiến hành giao dịch theo mức giá đã được yêu cầu trên ứng dụng",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              ),
              SizedBox(
                  height: 20
              ),
              ExpansionCard(
                borderRadius: 20,
                background: Image.asset(
                  "images/anhgif/confirm.gif",
                  fit: BoxFit.cover,
                ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Xác nhận giao dịch",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Bước 3",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: Text("Sau khi cả hai đã tiến hành giao dịch thành công, ở màn hình lịch sử giao dịch cả hai sẽ xác nhận mức độ hài lòng cho đối phương nếu nhấn nút thành công đối phương sẽ được tăng uy tín ngược lại ấn nút thất bại đối phương sẽ bị giảm uy tín",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              ),
              SizedBox(
                  height: 20
              ),
              ExpansionCard(
                borderRadius: 20,
                background: Image.asset(
                  "images/anhgif/post.gif",
                  fit: BoxFit.cover,
                ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Đăng sản phẩm",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: Text("Người dùng vào mục cá nhân chọn vào thêm sản phẩm (điền đầy đủ thông tin của mình) để đưa lên ứng dụng ngoài ra có thể quản lý sản phẩm của mình qua mục sản phẩm của tôi",
                        style: TextStyle(fontSize: 20, color: Colors.black,)),
                  )
                ],
              ),
              SizedBox(
                  height: 50
              ),
            ],
        ));
  }
}

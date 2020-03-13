import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/category/nongsan.png',
            image_caption: 'Thực Phẩm Sạch',
          ),

          Category(
            image_location: 'images/category/suckhoe.png',
            image_caption: 'Sức Khỏe-Sắc Đẹp',
          ),

          Category(
            image_location: 'images/category/hangnhapkhau.png',
            image_caption: 'Hàng Nhập Khẩu',
          ),

          Category(
            image_location: 'images/category/thoitrang.png',
            image_caption: 'Thời Trang',
          ),

          Category(
            image_location: 'images/category/dulich.png',
            image_caption: 'Du Lịch',
          ),

          Category(
            image_location: 'images/category/xaydung.png',
            image_caption: 'Xây Dựng',
          ),

          Category(
            image_location: 'images/category/congnghe.png',
            image_caption: 'Điện Máy',
          ),

          Category(
            image_location: 'images/category/batdongsan.png',
            image_caption: 'Bất Động Sản',
          ),

          Category(
            image_location: 'images/category/truyennghe.png',
            image_caption: 'Truyền Nghề',
          ),

          Category(
            image_location: 'images/category/congviec.png',
            image_caption: 'Việc Làm',
          ),

          Category(
            image_location: 'images/category/baohiem.png',
            image_caption: 'Bảo Hiểm',
          ),

          Category(
            image_location: 'images/category/quatang.png',
            image_caption: 'Quà Tặng',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_caption, this.image_location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 120.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption,style: new TextStyle(fontSize: 12.0),),
            ),
          ),
        ),
      ),
    );
  }
}

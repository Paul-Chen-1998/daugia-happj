import 'package:firebase_database/firebase_database.dart';

class Product {
  var key;
  var name;
  var userId;
  var nameType;
  var status;
  var description;
  var extraTime;
  var registerDate;
  var startPrice;
  var hide;
  var currentPrice;
  var uyTin;
  List played;
  List winner;
  List img;
  List message;
  List fcms;
  Product(
      {this.key,
      this.name,
      this.userId,
      this.nameType,
      this.status,
      this.description,
      this.extraTime,
      this.registerDate,
      this.startPrice,
      this.hide,
      this.currentPrice,
      this.played,
      this.winner,
      this.img,
      this.message,
      this.uyTin,
        this.fcms});

  factory Product.fromSnapshot(DataSnapshot snapshot) {
    return Product(
        name: snapshot.value['nameProduct'],
        key: snapshot.key,
        status: snapshot.value['status'],
        extraTime: snapshot.value['extraTime'],
        description: snapshot.value['description'],
        img: snapshot.value['imageProduct'],
        nameType: snapshot.value['nameProductType'],
        registerDate: snapshot.value['registerDate'],
        startPrice: snapshot.value['startPriceProduct'],
        userId: snapshot.value['userId'],
        winner: snapshot.value['winner'],
        hide: snapshot.value['hide'],
        currentPrice: snapshot.value['currentPrice'],
        played: snapshot.value['played'],
        message: snapshot.value['message'],
      fcms: snapshot.value['fcms'],
      uyTin: snapshot.value['uyTin']);
  }
}

//class Product {
//  String userId;
//  String nameProduct;
//  int priceProduct;
//  String imageProduct;
//  DateTime create_at;
//
//  Product(
//      {this.id,
//      this.nameProduct,
//      this.priceProduct,
//      this.imageProduct,
//      this.create_at});
//
//    factory Product.fromJson(Map<String, dynamic> json) => Product(
//      id: json['_id'],
//      nameProduct: json['nameProduct'],
//      priceProduct: json['priceProduct'],
//      imageProduct: json['imageProduct'],
//      create_at: json['create_at']);
//
//}

class Product {
  String id;
  String nameProduct;
  int priceProduct;
  String imageProduct;
  DateTime create_at;

  Product(
      {this.id,
      this.nameProduct,
      this.priceProduct,
      this.imageProduct,
      this.create_at});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['_id'],
      nameProduct: json['nameProduct'],
      priceProduct: json['priceProduct'],
      imageProduct: json['imageProduct'],
      create_at: json['create_at']);
}

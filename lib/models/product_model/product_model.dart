import 'dart:convert';

ProductModel ProductModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String ProductModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String image;
  bool isFavourite;
  String name;
  double price;
  String description;

  int? qty;

  ProductModel(
      {required this.id,
      required this.image,
      required this.isFavourite,
      required this.name,
      required this.price,
      required this.description,
      this.qty});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "qty": qty
      };

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
          id: id,
          name: name,
          description: description,
          image: image,
          isFavourite: isFavourite,
          qty: qty ?? this.qty,
          price: price);
}

import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  OrderModel(
      {required this.payment,
      required this.orderId,
      required this.status,
      required this.totalPrice,
      required this.products,
      required this.date});

  String payment;
  Timestamp date;

  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json['products'];
    return OrderModel(
        orderId: json["orderId"],
        products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
        totalPrice: json["totalprice"],
        status: json["status"],
        date: json["date"],
        payment: json['payment']);
  }
}

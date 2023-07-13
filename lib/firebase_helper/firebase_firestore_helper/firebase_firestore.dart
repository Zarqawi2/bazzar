import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/models/category_model/category_model.dart';
import 'package:bazzar_app/models/order_model/order_model.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("catagories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('catagories')
              .doc(id)
              .collection('products')
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }

      DocumentReference documentReference = _firebaseFirestore
          .collection('usersOrders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .doc();

      DocumentReference admin = _firebaseFirestore.collection('orders').doc();

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": admin.id,
        "date": Timestamp.now(), //ama bo awaya xoy katek dabne ka krawa
      });

      documentReference.set({
        'products': list.map((e) => e.toJson()),
        'status': 'pending',
        'totalprice': totalPrice,
        'payment': payment,
        'orderId': documentReference.id,
        'date': Timestamp.now(),
      });

      Navigator.of(context, rootNavigator: true).pop();
      showMessage('داواکاریەکەت زیادکرا');
      return true;
    } catch (e) {
      showMessage(e.toString());

      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  // get order / / / /// / / / / / / /  / / / / ///// / / / /

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('usersOrders')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .get();

      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();

      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

//// delete order  / / / / / / / / / / // / //

  Future<void> deleteAllOrders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('usersOrders')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
    } catch (e) {
      showMessage(e.toString());
    }
  }

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'notificationToken': token,
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/order_model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
              FirebaseFirestoreHelper.instance.deleteAllOrders();
              setState(() {});
            },
            icon: Icon(FontAwesomeIcons.trash),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "کڕینەکانت",
          style: TextStyle(color: Colors.black, fontFamily: 'speda'),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(
          FirebaseFirestoreHelper.instance.getUserOrder(),
        ),
        // future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 137, 137),
              ),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("....هیچ کڕینێک بوونی نییە"),
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        FontAwesomeIcons.refresh,
                        color: Color.fromARGB(255, 255, 137, 137),
                      )),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    iconColor: Colors.blueAccent.withOpacity(.4),
                    collapsedTextColor: Colors.blueAccent.withOpacity(.4),
                    tilePadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                            color: Colors.blueAccent.withOpacity(.4),
                            width: 1)),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: Image.network(
                              orderModel.products[0].image,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderModel.products[0].name,
                                  style: const TextStyle(),
                                ),
                                orderModel.products.length > 1
                                    ? SizedBox.fromSize()
                                    : Column(
                                        children: [
                                          Text(
                                            "دانە: ${orderModel.products[0].qty.toString()}",
                                            style: const TextStyle(
                                                fontFamily: 'speda',
                                                fontSize: 14),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                Text(
                                  "کۆی گشتی: \$${orderModel.totalPrice.toString()}",
                                  style: const TextStyle(
                                      fontFamily: 'speda', fontSize: 14),
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  "دۆخی کڕین: ${orderModel.status}",
                                  style: const TextStyle(
                                      fontFamily: 'roboto', fontSize: 14),
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'بەرواری: ${DateTime.fromMicrosecondsSinceEpoch(orderModel.date.millisecondsSinceEpoch * 1000)}',
                                  style: const TextStyle(
                                      fontFamily: 'speda', fontSize: 14),
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'کۆد: ${orderModel.orderId}',
                                  style: const TextStyle(
                                      fontFamily: 'roboto', fontSize: 14),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            Text("وردەکاری"),
                            Divider(color: Colors.blueAccent.withOpacity(.4)),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding: EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.blueAccent),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "دانە: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color:
                                                            Colors.blueAccent),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "نرخ: \$${singleProduct.price.toString()}",
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.blueAccent),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color:
                                            Colors.blueAccent.withOpacity(.4)),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

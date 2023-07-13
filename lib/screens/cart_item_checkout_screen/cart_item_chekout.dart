import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:bazzar_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:bazzar_app/strip_helper/strip_helper.dart.dart';
import 'package:bazzar_app/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({super.key});

  @override
  State<CartItemCheckout> createState() => _CheckoutState();
}

class _CheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'پشکنین',
          style: TextStyle(color: Colors.black54, fontFamily: 'speda'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.blueAccent.withOpacity(.4), width: 1),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.payment_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'پارەدان لەکاتی گەیاندن',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.blueAccent.withOpacity(.4), width: 1),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.paypal_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'پارەدانی ئۆنلاین',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            primaryButton(
              title: 'بەردەوامبوون',
              onPressed: () async {
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          context,
                          'cash on dilevery');
                  if (value) {
                    Future.delayed(Duration(seconds: 2), () {
                      Routes.instance
                          .push(widget: CustomBottomBar(), context: context);
                    });
                  }
                } else {
                  int value = double.parse(
                          appProvider.totalPriceBuyProductList().toString())
                      .round()
                      .toInt();
                  String totalPrice = (value * 100).toString();
                  await StripeHelper.instance
                      .makePayment(totalPrice.toString(), context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

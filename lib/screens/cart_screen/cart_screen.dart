import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:bazzar_app/screens/cart_item_checkout_screen/cart_item_chekout.dart';
import 'package:bazzar_app/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      bottomNavigationBar: appProvider.getCartProductList.isEmpty
          ? Text('')
          : SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${appProvider.totalPrice().toString()}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'هەمووی',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    primaryButton(
                      title: 'کڕین',
                      onPressed: () {
                        appProvider.clearBuyProduct();
                        appProvider.addBuyProductCartList();
                        appProvider.clearCart();
                        // if (appProvider.getBuyProductList.isEmpty) {
                        //   showMessage('Buy Item Beffore pressed');
                        // } else {
                        //   Routes.instance.push(
                        //       widget: CartItemCheckout(), context: context);
                        // }
                        Routes.instance
                            .push(widget: CartItemCheckout(), context: context);
                      },
                    )
                  ],
                ),
              ),
            ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'سەبەتە',
          style: TextStyle(color: Colors.black54, fontFamily: 'speda'),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "هیچت زیادنەکردووە بۆ ئێرە ....",
                    textDirection: TextDirection.rtl,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      tooltip: 'barham',
                      icon: Icon(
                        FontAwesomeIcons.refresh,
                        size: 30,
                        color: Color.fromARGB(255, 255, 137, 137),
                      )),
                ],
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}

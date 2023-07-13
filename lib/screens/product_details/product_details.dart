import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:bazzar_app/screens/check_out_screen/check_out.dart';
import 'package:bazzar_app/screens/cart_screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Color.fromARGB(255, 58, 166, 185),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 2),
            badgeAnimation: badges.BadgeAnimation.size(),
            showBadge: appProvider.getCartProductList.length > 0 ? true : false,
            badgeContent: FittedBox(
              child: Text(
                appProvider.getCartProductList.length > 0
                    ? "${appProvider.getCartProductList.length}"
                    : "${0}",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Routes.instance.push(widget: CartScreen(), context: context);
                },
                icon: Icon(FontAwesomeIcons.cartShopping)),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(
                      appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Color.fromARGB(206, 210, 0, 25),
                    ),
                  ),
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'roboto'),
                  ),
                ],
              ),
              Text(
                widget.singleProduct.description,
                style: TextStyle(fontFamily: 'roboto'),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(206, 210, 0, 25),
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 56, 229, 76),
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              // Spacer(),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 38,
                    width: 100,
                    child: qty > 0
                        ? ElevatedButton(
                            onPressed: () {
                              ProductModel productModel =
                                  widget.singleProduct.copyWith(qty: qty);
                              Routes.instance.push(
                                  widget: Checkout(
                                    singleProduct: productModel,
                                  ),
                                  context: context);
                            },
                            child: const Text("کڕین"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 46, 176, 135)),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  qty > 0
                      ? OutlinedButton(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);
                            appProvider.addCartProduct(productModel);
                            showMessage("زیادکرا بۆ سەبەتە");
                          },
                          child: const Text("زیادکردن بۆ سەبەتە"),
                        )
                      : Flexible(
                          child: Text(
                            'تکایە ئەگەر ئەتەوێت ئەم بەرهەمە بیکڕیت ژمارەی بەرهەمەکەزیاد بکە   ',
                            style: TextStyle(
                              fontFamily: 'speda',
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

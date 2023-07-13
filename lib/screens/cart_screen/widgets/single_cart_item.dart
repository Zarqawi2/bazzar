import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        //color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 140,
                color: Colors.yellow.shade700.withOpacity(.01),
                child: Image.network(widget.singleProduct.image)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.singleProduct.name,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      if (qty >= 2) {
                                        setState(() {
                                          qty--;
                                        });
                                        appProvider.updateQty(
                                            widget.singleProduct, qty);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    child: CircleAvatar(
                                      maxRadius: 13,
                                      backgroundColor:
                                          Color.fromARGB(206, 210, 0, 25),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    qty.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        qty++;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    },
                                    padding: EdgeInsets.zero,
                                    child: CircleAvatar(
                                      maxRadius: 13,
                                      backgroundColor:
                                          Color.fromARGB(244, 60, 207, 77),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: CupertinoButton(
                                  onPressed: () {
                                    if (!appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)) {
                                      appProvider.addFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage('زیادکرا');
                                    } else {
                                      appProvider.removeFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage('لابرا');
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    appProvider.getFavouriteProductList
                                            .contains(widget.singleProduct)
                                        ? 'لابردن لە بەشی دڵخواز'
                                        : 'زیادکردن بۆ بەشی دڵخواز',
                                    style: TextStyle(
                                        fontFamily: 'speda',
                                        fontSize: 15.0,
                                        color:
                                            Color.fromARGB(255, 255, 137, 137)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${widget.singleProduct.price.toString()}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          showMessage('لابرا');
                        },
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(206, 210, 0, 25),
                          maxRadius: 13,
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

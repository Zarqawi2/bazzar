import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 140, child: Image.network(widget.singleProduct.image)),
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
                                style: TextStyle(fontFamily: 'roboto'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Flexible(
                                child: CupertinoButton(
                                  onPressed: () {
                                    AppProvider appProvider =
                                        Provider.of<AppProvider>(context,
                                            listen: false);
                                    appProvider.removeFavouriteProduct(
                                        widget.singleProduct);
                                    showMessage('لابرا');
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'سڕینەوە لە لیستی دڵخواز',
                                    style: TextStyle(
                                        fontFamily: 'speda',
                                        color:
                                            Color.fromARGB(255, 243, 36, 36)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${widget.singleProduct.price.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'roboto'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

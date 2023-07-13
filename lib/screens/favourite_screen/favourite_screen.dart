import 'package:bazzar_app/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'لیستی دڵخوازەکان',
          style: TextStyle(color: Colors.black54, fontFamily: 'speda'),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text(
                'هیچت زیاد نەکردووە بۆ ئێرە ....',
                style: TextStyle(
                  fontSize: 18,
                ),
                textDirection: TextDirection.rtl,
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              },
              
            ),
            
    );
  }
}

import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:bazzar_app/models/category_model/category_model.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade700,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: kToolbarHeight * 1.5,
                        ),
                        BackButton(
                          color: Color.fromARGB(255, 255, 137, 137),
                        ),
                        Text(
                          widget.categoryModel.name,
                          style: TextStyle(fontSize: 20, fontFamily: 'roboto'),
                        ),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? Center(
                          child: Text(
                            'باشترین بەرهەم بەتاڵە...',
                            textDirection: TextDirection.rtl,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, bottom: 12),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productModelList.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.75,
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        Colors.yellow.shade700.withOpacity(.01),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Image.network(
                                        singleProduct.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: FittedBox(
                                          child: Text(
                                            singleProduct.name.toLowerCase(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontFamily: 'roboto'),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'نرخ: \$${singleProduct.price}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontFamily: 'speda'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          child: Text(
                                            'زیاتر',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  )
                ],
              ),
            ),
    );
  }
}

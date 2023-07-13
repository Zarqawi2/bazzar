import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:bazzar_app/models/category_model/category_model.dart';
import 'package:bazzar_app/models/product_model/product_model.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:bazzar_app/screens/category_view/category_view.dart';
import 'package:bazzar_app/screens/product_details/product_details.dart';
import 'package:bazzar_app/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    getCategoryList();
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //search   // / / /  / / / /

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 233, 0, 101),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                appProvider.getUserInformation.image == null
                                    ? const Icon(
                                        FontAwesomeIcons.person,
                                        size: 20,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            appProvider
                                                .getUserInformation.image!),
                                        radius: 20,
                                      ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  appProvider.getUserInformation.name,
                                  style: const TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'roboto'),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                badges.Badge(
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Colors.green,
                                    shape: badges.BadgeShape.circle,
                                  ),
                                  showBadge: true,
                                  // badgeContent: Text(''),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_basket,
                                  color: Color.fromARGB(255, 255, 133, 81),
                                ),
                                TopTitels(subtitle: '', title: 'بازاڕ'),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 30,
                        ),
                        TextFormField(
                          textDirection: TextDirection.rtl,
                          onChanged: (value) {
                            searchProducts(value);
                          },
                          controller: search,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            hintText: 'گەڕان',
                            hintStyle: TextStyle(fontFamily: 'speda'),
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              color: Color.fromARGB(255, 255, 137, 137)
                                  .withOpacity(.7),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 50,
                        ),
                        Text(
                          'بەشەکان',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? Center(
                          child: Text('بەشەکان بە تاڵن'),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Routes.instance.push(
                                              widget: CategoryView(
                                                  categoryModel: e),
                                              context: context);
                                        },
                                        child: Card(
                                          color: Colors.yellow.shade700
                                              .withOpacity(.02),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(e.image),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ),
                  !isSearched()
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12, top: 19),
                          child: Text(
                            'باشترین بەرهەم',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox.fromSize(),
                  SizedBox(
                    height: 20,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("ببورە ئەم بەرهەمە بوونی نییە"),
                        ) //ama bashi sercha
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.7,
                                          crossAxisCount: 2),
                                  itemBuilder: (ctx, index) {
                                    ProductModel singleProduct =
                                        searchList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.01),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Image.network(
                                            singleProduct.image,
                                            height: 120,
                                            width: 120,
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: FittedBox(
                                              child: Text(
                                                singleProduct.name
                                                    .toLowerCase(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("نرخ: \$${singleProduct.price}"),
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
                                              child: const Text(
                                                "زیاتر",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : productModelList.isEmpty
                              ? Center(
                                  child: Text('باشترین بەرهەم باتاڵە'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, bottom: 12),
                                  child: GridView.builder(
                                      padding: EdgeInsets.only(bottom: 50),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.yellow.shade700
                                                .withOpacity(.02),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Image.network(
                                                singleProduct.image,
                                                height: 120,
                                                width: 120,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: FittedBox(
                                                  child: Text(
                                                    singleProduct.name
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        fontFamily: 'roboto'),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  'نرخ: \$${singleProduct.price}'),
                                              SizedBox(
                                                height: 15,
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
                    height: MediaQuery.of(context).padding.top + 10,
                  )
                ],
              ),
            ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

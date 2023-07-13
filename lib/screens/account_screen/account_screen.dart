import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:bazzar_app/screens/about_us_screen/about_us.dart';
import 'package:bazzar_app/screens/change_password_screen/change_password.dart';
import 'package:bazzar_app/screens/edit_profile_screen/edit_profile.dart';
import 'package:bazzar_app/screens/favourite_screen/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../order_screen/order_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "هەژمار",
          style: TextStyle(
            fontFamily: 'speda',
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  appProvider.getUserInformation.email,
                  style: TextStyle(color: Colors.black38, fontFamily: 'roboto'),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                FittedBox(
                  child: SizedBox(
                    width: 160,
                    child: OutlinedButton(
                      child: Text("دەسکاری کردن"),
                      onPressed: () {
                        Routes.instance.push(
                            widget: const EditProfile(), context: context);
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(color: Color.fromARGB(255, 243, 36, 36)),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 243, 36, 36),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const OrderScreen(), context: context);
                  },
                  leading: Icon(FontAwesomeIcons.cartPlus,
                      color: Color.fromARGB(255, 243, 36, 36)),
                  title: Text(
                    "چیم کڕیوە",
                    style: TextStyle(fontFamily: 'speda'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: Icon(Icons.favorite,
                      size: 27, color: Color.fromARGB(255, 243, 36, 36)),
                  title: const Text(
                    "لیستی دڵخوازەکان",
                    style: TextStyle(fontFamily: 'speda'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const Aboutus(), context: context);
                  },
                  leading:
                      Icon(Icons.info, color: Color.fromARGB(255, 243, 36, 36)),
                  title: const Text(
                    "دەربارە",
                    style: TextStyle(fontFamily: 'speda'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: Icon(Icons.change_circle,
                      color: Color.fromARGB(255, 243, 36, 36)),
                  title: const Text(
                    "گۆڕینی وشەی نهێنی",
                    style: TextStyle(fontFamily: 'speda'),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    FirebaseAuthHelper.instance.signOut(context);
                    setState(() {});
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 243, 36, 36),
                  ),
                  title: const Text(
                    "چوونەدەرەوە",
                    style: TextStyle(fontFamily: 'speda'),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Center(
                    child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.black38),
                )),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bazzar_app/constants/asset_images.dart';
import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/screens/auth_ui/login/login.dart';
import 'package:bazzar_app/screens/auth_ui/sign_up/sign_up.dart';
import 'package:bazzar_app/widgets/primary_button/primary_button.dart';
import 'package:bazzar_app/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopTitels(
                subtitle: 'ئەپڵیکەیشنی بازاڕ بازاڕ ئەکاتە ماڵەکەتەوە',
                title: 'بەخێربێیت'),
            // SizedBox(
            //     height: MediaQuery.of(context).padding.top,
            //     ),
            Center(
              child: Image.asset(
                AssetsImages.instance.welcomeImage2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            primaryButton(
              title: 'چوونەژوورەوە',
              onPressed: () {
                Routes.instance.push(widget: Login(), context: context);
              },
            ),
            SizedBox(
              height: 12,
            ),
            primaryButton(
              title: 'خۆتۆمارکردن',
              onPressed: () {
                Routes.instance.push(widget: SignUp(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

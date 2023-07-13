// ignore_for_file: use_build_context_synchronously

import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:bazzar_app/screens/auth_ui/sign_up/sign_up.dart';
import 'package:bazzar_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:bazzar_app/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitels(
                  subtitle: "بەخێربێیت بۆ ئەپڵیکەیشنی بازاڕ",
                  title: "چوونەژوورەوە"),
              SizedBox(
                height: 46.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                controller: email,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: "ئیمەیل",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(255, 255, 133, 81),
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: "وشەیی نهێنی",
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: Color.fromARGB(255, 255, 133, 81),
                  ),
                  suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 255, 133, 81),
                      )),
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              Center(
                child: OutlinedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 133, 81),
                      ),
                      side: MaterialStatePropertyAll(BorderSide(
                          color: Color.fromARGB(255, 255, 133, 81)))),
                  child: Text("چونەژوورەوە"),
                  onPressed: () async {
                    bool isVaildated =
                        loginValidation(email.text, password.text);
                    if (isVaildated) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: const CustomBottomBar(), context: context);
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Center(child: Text("هەژمارت هەیە ؟")),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance
                        .push(widget: const SignUp(), context: context);
                  },
                  child: Text(
                    "دروستکردنی هەژمار",
                    style: TextStyle(
                        color: Color.fromARGB(
                          255,
                          255,
                          133,
                          81,
                        ),
                        fontFamily: 'speda',
                        fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

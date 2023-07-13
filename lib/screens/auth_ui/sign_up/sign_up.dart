import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/constants/routes.dart';
import 'package:bazzar_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:bazzar_app/screens/auth_ui/login/login.dart';
import 'package:bazzar_app/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                  title: 'دروستکردنی هەژمار'),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: name,
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: 'ناو',
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: Color.fromARGB(255, 0, 223, 164),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: 'ئیمەیڵ',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(255, 0, 223, 164),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: 'ژمارە مووبایل',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: Color.fromARGB(255, 0, 223, 164),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                cursorColor: Color.fromARGB(255, 255, 133, 81),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'speda'),
                  hintText: 'وشەیی نهێنی',
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    child: isShowPassword
                        ? Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 255, 133, 81),
                          )
                        : Icon(Icons.visibility_off,
                            color: Color.fromARGB(255, 255, 133, 81)),
                  ),
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: Color.fromARGB(255, 0, 223, 164),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: OutlinedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 0, 223, 164),
                      ),
                      side: MaterialStatePropertyAll(
                          BorderSide(color: Color.fromARGB(255, 0, 223, 164)))),
                  child: Text('دروستکردنی هەژمار'),
                  onPressed: () async {
                    bool isVaildated = signUpValidation(
                        email.text, password.text, name.text, phone.text);
                    if (isVaildated) {
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(
                          name.text, email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: const Login(), context: context);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text("هەژمارت هەبووە ؟"),
              ),
              // SizedBox(
              //   height: 8,
              // ),
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    //Routes.instance.push(widget: Login(), context: context);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'چوونەژوورەوە',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 223, 164),
                        fontFamily: 'speda'),
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

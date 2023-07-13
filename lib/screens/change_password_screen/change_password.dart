import 'package:bazzar_app/constants/constants.dart';
import 'package:bazzar_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:bazzar_app/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'گۆڕینی وشەی نهێنی',
          style: TextStyle(color: Colors.black54, fontFamily: 'speda'),
        ),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          children: [
            TextFormField(
              style: TextStyle(fontFamily: 'roboto'),
              controller: newPassword,
              obscureText: isShowPassword,
              cursorColor: Color.fromARGB(255, 0, 200, 150),
              decoration: InputDecoration(
                hintText: 'وشەی نهێنی نوێ',
                hintStyle: TextStyle(fontFamily: 'speda'),
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
                          color: Color.fromARGB(255, 0, 200, 150),
                        )
                      : Icon(Icons.visibility_off,
                          color: Color.fromARGB(255, 0, 200, 150)),
                ),
                prefixIcon: Icon(
                  Icons.password_outlined,
                  color: Color.fromARGB(255, 0, 200, 150),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(fontFamily: 'roboto'),
              controller: confirmPassword,
              obscureText: isShowConfirmPassword,
              cursorColor: Color.fromARGB(255, 0, 200, 150),
              decoration: InputDecoration(
                hintText: 'دڵنیاکردنەوەی وشەی نهێنی',
                hintStyle: TextStyle(fontFamily: 'speda'),
                suffixIcon: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isShowConfirmPassword = !isShowConfirmPassword;
                    });
                  },
                  child: isShowConfirmPassword
                      ? Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 0, 200, 150),
                        )
                      : Icon(Icons.visibility_off,
                          color: Color.fromARGB(255, 0, 200, 150)),
                ),
                prefixIcon: Icon(Icons.password_outlined,
                    color: Color.fromARGB(255, 0, 200, 150)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.top + 10,
            ),
            primaryButton(
              title: 'گۆڕین',
              onPressed: () async {
                if (newPassword.text.isEmpty) {
                  showMessage("تکایە وشەی نهێنی نوێ پڕبکەرەوە");
                } else if (confirmPassword.text.isEmpty) {
                  showMessage("تکایە دڵنیاکردنەوەی وشەی نهێنی پڕبکەرەوە");
                } else if (newPassword.text.length < 8 ||
                    confirmPassword.text.length < 8) {
                  showMessage("تکایە با وشەی نهێنی لە ٨ پیت کەمتر نەبێت");
                } else if (confirmPassword.text == newPassword.text) {
                  FirebaseAuthHelper.instance
                      .changePassword(newPassword.text, context);
                } else {
                  showMessage("تکایە وشەیی نهێنی با وەک یەک بن");
                }
              },
            )
          ]),
    );
  }
}

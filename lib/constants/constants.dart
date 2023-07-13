import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    gravity: ToastGravity.TOP,
    msg: message,
    backgroundColor: Colors.yellow.shade700,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 233, 0, 101),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading...")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "ئەم ئیمەیلە پێشتر داخڵ کراوە";
    case "account-exists-with-different-credential":
      return "ئەم هەژمارە پێشتر تۆمارکراوە.";
    case "email-already-in-use":
      return "ئەم ئیمیلە بەکارهاتووە";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "وشەیی نهێنی هەڵەیە ";
    case "ERROR_USER_NOT_FOUND":
      return "هیچ هەژمارێک بوونی نییە ";
    case "user-not-found":
      return "هیچ هەژمارێک بوونی نییە ";
    case "ERROR_USER_DISABLED":
      return "هەژمارەکە داخراوە.";
    case "user-disabled":
      return "هەژمارەکە داخراوە.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "داواکاری زۆر لەسەرە ئەم هەژمارە.";
    case "operation-not-allowed":
      return "داواکاری زۆر لەسەرە ئەم هەژمارە.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "داواکاری زۆر لەسەرە ئەم هەژمارە.";
    case "ERROR_INVALID_EMAIL":
      return "تکایە ئیمیلی دروست بنوسە.";
    case "invalid-email":
      return "تکایە ئیمەیلی دروست بنوسە.";
    default:
      return "هەلەیەک ڕویدا تکایە دووبارەی بکەرەوە.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage('تکایە بۆکسەکان پڕبکەرەوە');
    return false;
  } else if (email.isEmpty) {
    showMessage('تکایە بۆکسی ئیمەیل پڕبکەرەوە');
    return false;
  } else if (password.isEmpty) {
    showMessage('تکایە بۆکسی وشەیی نهێنی پڕبکەرەوە');
    return false;
  } else if (password.length < 8) {
    showMessage('تکایە وشەیی نهێنی با لە ٨ پیت کەمتر نەبێ');
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage('تکایە بۆکسەکان پڕبکەرەوە');
    return false;
  } else if (password.length < 8) {
    showMessage('تکایە وشەیی نهێنی با لە ٨ پیت کەمتر نەبێ');
    return false;
  } else if (email.isEmpty) {
    showMessage('تکایە بۆکسی ئیمەیل پڕبکەرەوە');
    return false;
  } else if (password.isEmpty) {
    showMessage('تکایە بۆکسی وشەیی نهێنی پڕبکەرەوە');
    return false;
  } else if (name.isEmpty) {
    showMessage('تکایە بۆکسی ناو پڕبکەرەوە');
    return false;
  } else if (phone.isEmpty) {
    showMessage('تکایە بۆکسی ژمارە مووبایل پڕبکەرەوە');
    return false;
  } else {
    return true;
  }
}

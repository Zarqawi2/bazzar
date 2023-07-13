import 'dart:io';

import 'package:bazzar_app/models/user_model/user_model.dart';
import 'package:bazzar_app/provider/app_provider.dart';
import 'package:bazzar_app/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'پڕۆفایل',
          style: TextStyle(color: Colors.black54, fontFamily: 'speda'),
        ),
      ),
      body: ListView(padding: EdgeInsets.symmetric(horizontal: 20), children: [
        image == null
            ? CupertinoButton(
                onPressed: () {
                  takePicture();
                },
                child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 255, 137, 137),
                    radius: 55,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    )),
              )
            : CupertinoButton(
                onPressed: () {
                  takePicture();
                },
                child: CircleAvatar(
                  backgroundImage: FileImage(image!),
                  radius: 55,
                ),
              ),
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: appProvider.getUserInformation.name,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 137, 137)))),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.top + 10,
        ),
        primaryButton(
          title: 'تازەکردنەوە',
          onPressed: () async {
            UserModel userModel = appProvider.getUserInformation
                .copyWith(name: textEditingController.text);
            appProvider.updateUserInfoFirebase(context, userModel, image);
          },
        )
      ]),
    );
  }
}

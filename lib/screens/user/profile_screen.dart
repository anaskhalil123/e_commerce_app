import 'dart:io';

import 'package:e_commerce_app/preferences/app_preferences.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

import '../../fireBase/storage_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  AppPrefernces appPrefernces = AppPrefernces();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController aboutYourSelfController = TextEditingController();
  File? imageFile;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    userNameController.text = appPrefernces.myName;
    userEmailController.text = appPrefernces.myEmail;
    passwordController.text = '****************';
    aboutYourSelfController.text = appPrefernces.writeAboutMySelf;
    if (appPrefernces.myImage.isNotEmpty) {
      imageUrl = appPrefernces.myImage;
      print('my image is' + imageUrl!);
    }
    // print('my image is' + imageUrl!);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(0.21),
                blurRadius: 6)
          ]),
          child: GestureDetector(
            onTap: () {
              _getFromGallery();
            },
            child: CircleAvatar(
              radius: 100,
              backgroundImage: imageUrl != null
                  ? Image.network(imageUrl!).image
                  : Image.asset(
                      'images/icons/pick_image.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.none,
                    ).image,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'USER NAME',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            appPrefernces.myName,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
        const Divider(
          height: 40,
          thickness: 1,
        ),
        EditTextWidget(
          text: 'User Name',
          type: Types.userName,
          textController: userNameController,
          whenPressEdit: () {
            setState(() {
              print('user nameeee');
            });
          },
        ),
        EditTextWidget(
            text: 'User Email',
            type: Types.userEmail,
            textController: userEmailController,
            whenPressEdit: () {
              setState(() {
                print('User Email edited');
              });
            }),
        EditTextWidget(
            text: 'Password',
            type: Types.userPassword,
            textController: passwordController,
            whenPressEdit: () {
              setState(() {
                print('User Password edited');
              });
            }),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            'Change Password',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
          ),
        ),
        EditTextWidget(
            text: 'Write About Your Self',
            type: Types.writeAboutYourSelf,
            textController: aboutYourSelfController,
            whenPressEdit: () {
              setState(() {
                print('User Write About Your Self edited');
              });
            }),
      ],
    );
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      await StorageController().uploadImage(
          file: File(imageFile!.path),
          eventHandler: (bool status, TaskState state, String message,
              {Reference? reference}) async {
            if (status) {
              //SUCCESS

              imageUrl = await reference!.getDownloadURL();

              // put imageUrl in shared
              appPrefernces.updateUserImage(image: imageUrl!);
              print(imageUrl);

              setState(() {
                showSnackBar(
                    context: context, content: 'image saved', error: false);
              });
            } else {
              if (state == TaskState.running) {
                //UPLOADING
                showSnackBar(
                    context: context,
                    content: 'image uploaded....',
                    error: false);
                // changeIndicatorValue(1);
              } else {
                //FAILED
                showSnackBar(context: context, content: 'filed', error: true);
              }
            }
          });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      uploadImage();
    }
  }
}

class EditTextWidget extends StatefulWidget {
  late final Function whenPressEdit;
  final String text;
  final Types type;
  TextEditingController textController;

  EditTextWidget(
      {Key? key,
      required this.text,
      required this.type,
      required this.whenPressEdit,
      required this.textController})
      : super(key: key);

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  bool isEnabled = false;
  Icon icon = Icon(Icons.edit);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 400,
      height: 75,
      child: Stack(
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 50,
            child: Stack(
              children: [
                TextFormField(
                  controller: widget.textController,
                  enabled: isEnabled,
                ),
                if (widget.text != 'Password' && widget.text != 'User Email')
                  Container(
                    alignment: Alignment.centerRight,
                    child: Material(
                      child: GestureDetector(
                          onTap: () {
                            print('print');
                            print(widget.whenPressEdit.toString());
                            if (isEnabled) {
                              isEnabled = false;
                              icon = Icon(Icons.edit);
                            } else if (isEnabled == false) {
                              isEnabled = true;
                              icon = Icon(Icons.save);
                            }
                            AppPrefernces appPrefernces = AppPrefernces();
                            switch (widget.type) {
                              case Types.userName:
                                {
                                  appPrefernces.updateUserName(
                                      name: widget.textController.text);
                                }
                                break;
                              case Types.userEmail:
                                {
                                  print(widget.textController.text);

                                  appPrefernces.updateUserEmail(
                                      email: widget.textController.text);

                                  print('email after get the method:' +
                                      appPrefernces.myEmail);
                                }
                                break;
                              case Types.writeAboutYourSelf:
                                {
                                  appPrefernces.updateWriteAboutYourSelf(
                                      writeAboutYourSelf:
                                          widget.textController.text);

                                  print('write about your self:' +
                                      appPrefernces.writeAboutMySelf);
                                }
                                break;

                              case Types.userPassword:
                                // TODO: Handle this case.
                                break;
                            }
                            widget.whenPressEdit();
                            print('controller : ' + widget.textController.text);
                          },
                          child: icon),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum Types { userName, userEmail, userPassword, writeAboutYourSelf }

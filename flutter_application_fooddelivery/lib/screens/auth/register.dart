import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/consts/my_validator.dart';
import 'package:flutter_application_/screens/auth/login.dart';
import 'package:flutter_application_/screens/inner_screens.dart/loading_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/app_name.dart';
import 'package:flutter_application_/widgets/auth/image_picker_widgets.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController txtname,
      txtemail,
      txtpassword,
      txtconfirmpassword;
  late final FocusNode txtnamefocus,
      txtemailfocus,
      txtpasswordfocus,
      txtconfirmpasswordfocus;
  late final _fromKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  XFile? pickerImage;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;
  @override
  void initState() {
    txtname = TextEditingController();
    txtemail = TextEditingController();
    txtpassword = TextEditingController();
    txtconfirmpassword = TextEditingController();
    txtnamefocus = FocusNode();
    txtemailfocus = FocusNode();
    txtpasswordfocus = FocusNode();
    txtconfirmpasswordfocus = FocusNode();
    super.initState();
  }

  void dispose() {
    txtname.dispose();
    txtemail.dispose();
    txtpassword.dispose();
    txtconfirmpassword.dispose();
    txtnamefocus.dispose();
    txtemailfocus.dispose();
    txtpasswordfocus.dispose();
    txtconfirmpasswordfocus.dispose();
    super.dispose();
  }

  Future<void> registerFct() async {
    final isValid = _fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _fromKey.currentState!.save();
      if (pickerImage == null) {
        MyAppMethods.showErrorOrWarningDialog(
            context: context,
            subtitle: "Make sure to pick up an image",
            fct: () {});
        return;
      }
      if (isValid) {
        _fromKey.currentState!.save();
        try {
          setState(() {
            isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("userImages")
              .child("${txtemail.text.trim()}.jpg");
          await ref.putFile(File(pickerImage!.path));
          userImageUrl = await ref.getDownloadURL();
          await auth.createUserWithEmailAndPassword(
            email: txtemail.text.trim(),
            password: txtpassword.text.trim(),
          );
          User? user = auth.currentUser;
          final uid = user!.uid;
          await FirebaseFirestore.instance.collection("users").doc(uid).set(
            {
              "userId": uid,
              "userName": txtname.text,
              "userImage": userImageUrl,
              "userEmail": txtemail.text.toLowerCase(),
              "createdAt": Timestamp.now(),
              "userWish": [],
              "userCart": [],
            },
          );
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 17,
          );
          if (!mounted) return;
          Navigator.pushNamed(context, LoginScreen.routeName);
        } on FirebaseAuthException catch (error) {
          if (!mounted) return;
          await MyAppMethods.showErrorOrWarningDialog(
              context: context,
              subtitle: "An error has been occured ${error.message}",
              fct: () {});
        } catch (error) {
          if (!mounted) return;
          await MyAppMethods.showErrorOrWarningDialog(
              context: context,
              subtitle: "An error has been occured $error",
              fct: () {});
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePicker(
        context: context,
        cameraFct: () async {
          pickerImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFct: () async {
          pickerImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFct: () {
          setState(() {
            pickerImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const AppName(
                    fs: 25,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(label: "Welcome!"),
                        SubtitleText(label: "Your welcome message !"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.width * 0.3,
                    width: size.height * 0.2,
                    child: ImagePickerWidgets(
                      function: () async {
                        await localImagePicker();
                      },
                      pickerImage: pickerImage,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtname,
                          focusNode: txtnamefocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          validator: (value) {
                            return MyValidator.displayNamevalidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(txtemailfocus);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtemail,
                          focusNode: txtemailfocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          validator: (value) {
                            return MyValidator.emailvalidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(txtpasswordfocus);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtpassword,
                          focusNode: txtpasswordfocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "**************",
                            prefixIcon: const Icon(IconlyLight.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            return MyValidator.passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(txtconfirmpasswordfocus);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtconfirmpassword,
                          focusNode: txtconfirmpasswordfocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(IconlyLight.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            return MyValidator.repeatPasswordValidator(
                                value: value, password: txtpassword.text);
                          },
                          onFieldSubmitted: (value) async {
                            await registerFct();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                              // backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                            ),
                            icon: const Icon(IconlyLight.addUser),
                            label: const Text("Sign up"),
                            onPressed: () async {
                              await registerFct();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SubtitleText(
                                label: "Already have an account!"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: const SubtitleText(
                                label: "Login",
                                textDecoration: TextDecoration.underline,
                                fst: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

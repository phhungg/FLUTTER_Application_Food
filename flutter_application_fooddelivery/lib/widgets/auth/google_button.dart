import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_/root_screens.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> googSignin({required BuildContext context}) async {
    final ggSignin = GoogleSignIn();
    final ggAccount = await ggSignin.signIn();
    if (ggAccount != null) {
      final ggAuth = await ggAccount.authentication;
      if (ggAuth.accessToken != null && ggAuth.idToken != null) {
        try {
          final authResult = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: ggAuth.accessToken,
              idToken: ggAuth.idToken,
            ),
          );
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResult.user!.uid)
                .set({
              "userId": authResult.user!.uid,
              "userName": authResult.user!.displayName,
              "userImage": authResult.user!.photoURL,
              "userEmail": authResult.user!.email,
              "createdAt": Timestamp.now(),
              "userWish": [],
              "userCart": [],
            });
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Navigator.pushReplacementNamed(context, RootScreens.routeName);
          });
        } on FirebaseException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialog(
                context: context,
                subtitle: "An error has been occured ${error.message}",
                fct: () {});
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialog(
                context: context,
                subtitle: "An error has been occured ${error}",
                fct: () {});
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onPressed: () {
        googSignin(context: context);
      },
      icon: const Icon(Ionicons.logo_google),
      label: const Text("Sign In with Google"),
    );
  }
}

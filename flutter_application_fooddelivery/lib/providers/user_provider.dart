import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/models/user_models.dart';

class UserProvider with ChangeNotifier {
  UserModels? userModels;
  UserModels? get getUsermodels {
    return userModels;
  }

  Future<UserModels?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userDocDict = userDoc.data();
      userModels = UserModels(
        userId: userDoc.get("userId"),
        userName: userDoc.get("userName"),
        userImage: userDoc.get("userImage"),
        userEmail: userDoc.get("userEmail"),
        createdAt: userDoc.get("createdAt"),
        userCart:
            userDocDict!.containsKey("userCart") ? userDoc.get("userCart") : [],
        userWish:
            userDocDict.containsKey("userWish") ? userDoc.get("userWish") : [],
      );
      return userModels;
    } on FirebaseAuthException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }
}

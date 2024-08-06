import 'package:flutter/material.dart';
import 'package:flutter_application_/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> wishlistItems = {};
  Map<String, WishlistModel> get getWishListItems {
    return wishlistItems;
  }

  bool isItemWishList({required String itemsId}) {
    return wishlistItems.containsKey(itemsId);
  }

  void addOrRemoveFormWishListItems({required String itemsId}) {
    if (wishlistItems.containsKey(itemsId)) {
      wishlistItems.remove(itemsId);
    } else {
      wishlistItems.putIfAbsent(itemsId,
          () => WishlistModel(id: const Uuid().v4(), itemsId: itemsId));
    }
    notifyListeners();
  }

  void clearWishList() {
    wishlistItems.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_/models/cart_models.dart';
import 'package:flutter_application_/models/items_category.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModels> cartItems = {};
  Map<String, CartModels> get getCartItems {
    return cartItems;
  }

  bool isCategoryInCart({required String foodId}) {
    return cartItems.containsKey(foodId);
  }

  void addCategory({required String foodId}) {
    cartItems.putIfAbsent(
        foodId,
        () => CartModels(
            cartId: const Uuid().v4(), categoryId: foodId, quality: 1));
    notifyListeners();
  }

  void updateQuality({required String categoriId, required int quality}) {
    cartItems.update(
        categoriId,
        (item) => CartModels(
            cartId: item.cartId, categoryId: categoriId, quality: quality));
    notifyListeners();
  }

  double getTotal({required ItemsCategory itemsCategory}) {
    double total = 0.0;
    cartItems.forEach((key, value) {
      final ItemsCategoryModel? getCurrentItems =
          itemsCategory.findByFoodid(value.categoryId);
      if (getCurrentItems == null) {
        total += 0;
      } else {
        total += double.parse(getCurrentItems.foodPrice) * value.quality;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    cartItems.forEach((key, value) {
      total += value.quality;
    });
    return total;
  }

  void removeItems({required String foodId}) {
    cartItems.remove(foodId);
    notifyListeners();
  }

  void clearItems() {
    cartItems.clear();
    notifyListeners();
  }
}

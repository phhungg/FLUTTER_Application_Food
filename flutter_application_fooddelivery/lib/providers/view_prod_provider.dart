import 'package:flutter/material.dart';
import 'package:flutter_application_/models/view_pro_models.dart';
import 'package:uuid/uuid.dart';

class ViewProdProvider with ChangeNotifier {
  final Map<String, ViewProModels> viewProItems = {};
  Map<String, ViewProModels> get getViewProItems {
    return viewProItems;
  }

  void addProHistory({required String cartId}) {
    viewProItems.putIfAbsent(
        cartId,
        () =>
            ViewProModels(viewedProdId: const Uuid().v4(), productId: cartId));
    notifyListeners();
  }

  void clearWishList() {
    viewProItems.clear();
    notifyListeners();
  }
}

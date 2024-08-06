import 'package:flutter/material.dart';

class CartModels with ChangeNotifier {
  final String cartId;
  final String categoryId;
  final int quality;

  CartModels(
      {required this.cartId, required this.categoryId, required this.quality});
}

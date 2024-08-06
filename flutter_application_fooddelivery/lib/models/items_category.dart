import 'package:flutter/material.dart';

class ItemsCategoryModel with ChangeNotifier {
  final String foodId,
      foodTitle,
      foodPrice,
      foodCategory,
      foodDescription,
      foodImage,
      foodQuanlity;

  ItemsCategoryModel(
      {required this.foodId,
      required this.foodTitle,
      required this.foodPrice,
      required this.foodCategory,
      required this.foodDescription,
      required this.foodImage,
      required this.foodQuanlity});
}

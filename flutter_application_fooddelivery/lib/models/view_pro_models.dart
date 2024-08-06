import 'package:flutter/material.dart';

class ViewProModels with ChangeNotifier {
  final String viewedProdId;
  final String productId;

  ViewProModels({required this.viewedProdId, required this.productId});
}

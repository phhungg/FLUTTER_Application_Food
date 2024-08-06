import 'package:flutter/material.dart';

class WishlistModel with ChangeNotifier {
  final String id, itemsId;

  WishlistModel({required this.id, required this.itemsId});
}

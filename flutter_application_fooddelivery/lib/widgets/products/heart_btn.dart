import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/wishlist_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HeartBtn extends StatefulWidget {
  final double size;
  final Color colors;
  final String itemsId;
  const HeartBtn({
    super.key,
    this.colors = Colors.transparent,
    this.size = 22,
    required this.itemsId,
  });

  @override
  State<HeartBtn> createState() => _HeartBtnState();
}

class _HeartBtnState extends State<HeartBtn> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colors,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
        ),
        onPressed: () {
          wishlistProvider.addOrRemoveFormWishListItems(
              itemsId: widget.itemsId);
        },
        icon: Icon(
          wishlistProvider.isItemWishList(itemsId: widget.itemsId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color: wishlistProvider.isItemWishList(itemsId: widget.itemsId)
              ? Colors.red
              : Colors.grey,
        ),
      ),
    );
  }
}

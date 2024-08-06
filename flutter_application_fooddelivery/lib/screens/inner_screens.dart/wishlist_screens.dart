import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/wishlist_provider.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/empty_widgets.dart';
import 'package:flutter_application_/widgets/products/products_widget.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class WishlistScreens extends StatefulWidget {
  static const routeName = "/WishListScreens";
  const WishlistScreens({super.key});
  final isEmpty = false;

  @override
  State<WishlistScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<WishlistScreens> {
  late TextEditingController txtsearch;
  @override
  void initState() {
    txtsearch = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishListItems.isEmpty
        ? Scaffold(
            body: EmptyWidgets(
              imagePath: AssetsManager.shoppingBasket,
              title: "You Wishlist is empty",
              subtitle:
                  "Looks like you didn\'t add anything yet to your cart \ngo",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleText(
                  label:
                      "WishList (${wishlistProvider.getWishListItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.wishlistSvg),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          wishlistProvider.clearWishList();
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                  ),
                )
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishListItems.length,
              builder: ((context, index) {
                return ProductsWidget(
                    productId: wishlistProvider.getWishListItems.values
                        .toList()[index]
                        .itemsId);
              }),
              crossAxisCount: 2,
            ),
          );
  }
}

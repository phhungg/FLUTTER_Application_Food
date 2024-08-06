import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/screens/cart/cart_button_checkout.dart';
import 'package:flutter_application_/screens/cart/cart_widgets.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/empty_widgets.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatelessWidget {
  const CartScreens({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final categoryprovider = Provider.of<CartProvider>(context);
    return categoryprovider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyWidgets(
              buttonText: "Shop Now",
              imagePath: AssetsManager.trolley,
              subtitle:
                  "Looks like your cart is empty.\nAdd something and make me happy.",
              title: "Your cart is empty",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          categoryprovider.clearItems();
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                  ),
                )
              ],
              title: TitleText(
                label: "Cart (${categoryprovider.getCartItems.length})",
                fS: 17,
              ),
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 10),
              child: ListView.builder(
                itemCount: categoryprovider.getCartItems.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: categoryprovider.getCartItems.values.toList()[index],
                    child: const CartWidgets(),
                  );
                },
              ),
            ),
            bottomSheet: const CartButtonCheckout(),
          );
  }
}

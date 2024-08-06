import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class CartButtonCheckout extends StatelessWidget {
  const CartButtonCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<CartProvider>(context);
    final itemsProvider = Provider.of<ItemsCategory>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
            top: BorderSide(
          width: 1,
          color: Colors.grey,
        )),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitleText(
                        label:
                            "Total ${cartprovider.getCartItems.length} products / ${cartprovider.getQty()} items",
                      ),
                    ),
                    SubtitleText(
                      label:
                          "\$ ${cartprovider.getTotal(itemsCategory: itemsProvider)}",
                      fS: 20,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

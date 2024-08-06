import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/widgets/app_name.dart';
import 'package:flutter_application_/widgets/products/heart_btn.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class CartDetails extends StatefulWidget {
  static const routeName = "/FoodDescription";
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final itemCategory = Provider.of<ItemsCategory>(context, listen: false);
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentCart = itemCategory.findByFoodid(itemId);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppName(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentCart!.foodImage,
              height: size.height * 0.4,
              width: double.infinity,
              boxFit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrentCart.foodTitle,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SubtitleText(
                        label: "\$${getCurrentCart.foodPrice}",
                        color: Colors.red,
                        fS: 17,
                        fw: FontWeight.bold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Row(
                      children: [
                        HeartBtn(
                          itemsId: getCurrentCart.foodId,
                          colors: Colors.red.shade300,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                if (cartProvider.isCategoryInCart(
                                    foodId: getCurrentCart.foodId)) {
                                  return;
                                }
                                cartProvider.addCategory(
                                    foodId: getCurrentCart.foodId);
                              },
                              icon: Icon(cartProvider.isCategoryInCart(
                                      foodId: getCurrentCart.foodId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined),
                              label: Text(cartProvider.isCategoryInCart(
                                      foodId: getCurrentCart.foodId)
                                  ? "In cart"
                                  : "Add to cart"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleText(label: "About this item"),
                      SubtitleText(label: getCurrentCart.foodCategory),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SubtitleText(label: getCurrentCart.foodDescription),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

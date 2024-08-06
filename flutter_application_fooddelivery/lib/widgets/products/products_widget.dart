import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/screens/inner_screens.dart/cart_details.dart';
import 'package:flutter_application_/widgets/products/heart_btn.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatefulWidget {
  final String productId;
  const ProductsWidget({super.key, required this.productId});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final itemCategory = Provider.of<ItemsCategory>(context);
    final getCurrentItems = itemCategory.findByFoodid(widget.productId);
    final cartprovider = Provider.of<CartProvider>(context);
    return getCurrentItems == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, CartDetails.routeName,
                    arguments: getCurrentItems.foodId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentItems.foodImage,
                      height: size.height * 0.2,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleText(
                          label: getCurrentItems.foodTitle,
                          maxlines: 2,
                          fS: 17,
                        ),
                      ),
                      Flexible(
                        child: HeartBtn(
                          itemsId: getCurrentItems.foodId,
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleText(label: '\$${getCurrentItems.foodPrice}'),
                        Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                            child: InkWell(
                              splashColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                if (cartprovider.isCategoryInCart(
                                    foodId: getCurrentItems.foodId)) {
                                  return;
                                }
                                cartprovider.addCategory(
                                    foodId: getCurrentItems.foodId);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  cartprovider.isCategoryInCart(
                                          foodId: getCurrentItems.foodId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart,
                                  size: 17,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

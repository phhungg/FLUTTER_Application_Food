import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/models/cart_models.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/screens/cart/qnt_bottom_sheet.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartWidgets extends StatelessWidget {
  const CartWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModels>(context);
    final categoryProvider = Provider.of<ItemsCategory>(context);
    final getCurrentItems =
        categoryProvider.findByFoodid(cartModelProvider.categoryId);
    Size size = MediaQuery.of(context).size;
    final itemsProvider = Provider.of<CartProvider>(context);
    return getCurrentItems == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentItems.foodImage,
                        height: size.height * 0.17,
                        width: size.height * 0.2,
                      ),
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(21.0),
                                child: SizedBox(
                                  width: size.width * 0.6,
                                  child: TitleText(
                                    label: getCurrentItems.foodTitle,
                                    maxlines: 2,
                                    fS: 24,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      itemsProvider.removeItems(
                                          foodId: getCurrentItems.foodId);
                                    },
                                    icon: Icon(
                                      IconlyLight.delete,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      IconlyBold.heart,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(21.0),
                                child: SubtitleText(
                                  label: "\$${getCurrentItems.foodPrice}",
                                  fS: 19,
                                  color: Colors.red,
                                ),
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return QntBottomSheet(
                                        cartModels: cartModelProvider,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  IconlyLight.arrowDown2,
                                ),
                                label: TitleText(
                                    label: "Qty:${cartModelProvider.quality}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

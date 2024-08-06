import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/models/items_category.dart';
import 'package:flutter_application_/providers/view_prod_provider.dart';
import 'package:flutter_application_/screens/inner_screens.dart/cart_details.dart';
import 'package:flutter_application_/widgets/products/heart_btn.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class LastArrival extends StatelessWidget {
  const LastArrival({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewrecent = Provider.of<ViewProdProvider>(context);
    final itemsModel = Provider.of<ItemsCategoryModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewrecent.addProHistory(cartId: itemsModel.foodId);

          await Navigator.pushNamed(context, CartDetails.routeName,
              arguments: itemsModel.foodId);
        },
        child: SizedBox(
          width: size.width * 0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: itemsModel.foodImage,
                    width: size.width * 0.45,
                    height: size.width * 0.3,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${itemsModel.foodTitle}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartBtn(itemsId: itemsModel.foodId),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleText(
                        label: "\$${itemsModel.foodPrice}",
                        color: Colors.red,
                      ),
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

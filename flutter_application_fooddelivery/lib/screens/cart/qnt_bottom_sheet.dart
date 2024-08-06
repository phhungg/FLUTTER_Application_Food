import 'package:flutter/material.dart';
import 'package:flutter_application_/models/cart_models.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class QntBottomSheet extends StatelessWidget {
  final CartModels cartModels;
  const QntBottomSheet({super.key, required this.cartModels});

  @override
  Widget build(BuildContext context) {
    final itemsCategory = Provider.of<CartProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  itemsCategory.updateQuality(
                      categoriId: cartModels.categoryId, quality: index + 1);
                  Navigator.pop(context);
                },
                child: Center(
                  child: SubtitleText(
                    label: "${index + 1}",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

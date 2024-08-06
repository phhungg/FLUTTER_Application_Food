import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/search_screns.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';

class CartRounded extends StatelessWidget {
  final String image, name;
  const CartRounded({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreens.routeName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SubtitleText(
            label: name,
            fS: 15,
            fw: FontWeight.bold,
          )
        ],
      ),
    );
  }
}

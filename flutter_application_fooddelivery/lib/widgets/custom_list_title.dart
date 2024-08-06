import 'package:flutter/material.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomListTitle extends StatelessWidget {
  final String text, imagePath;
  final Function function;

  const CustomListTitle({
    super.key,
    required this.imagePath,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleText(label: text),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}

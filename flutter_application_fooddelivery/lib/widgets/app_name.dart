import 'package:flutter/material.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';

class AppName extends StatelessWidget {
  final double fs;
  const AppName({super.key, this.fs = 18});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: TitleText(
        label: "Mattela Restaurant",
        fS: fs,
      ),
      baseColor: const Color.fromARGB(255, 55, 54, 54),
      highlightColor: Color.fromARGB(255, 147, 143, 143),
    );
  }
}

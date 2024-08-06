import 'package:flutter/material.dart';
import 'package:flutter_application_/root_screens.dart';
import 'package:flutter_application_/screens/home_pages.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';

class EmptyWidgets extends StatelessWidget {
  final String imagePath, title, subtitle, buttonText;
  const EmptyWidgets({
    super.key,
    required this.buttonText,
    required this.imagePath,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            TitleText(
              label: "Whoops!",
              fS: 40,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            SubtitleText(
              label: title,
              fw: FontWeight.w700,
              fS: 23,
            ),
            const SizedBox(
              height: 10,
            ),
            SubtitleText(
              label: subtitle,
              fw: FontWeight.w500,
              fS: 14,
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
              onPressed: () {
                Navigator.pushNamed(context, RootScreens.routeName);
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

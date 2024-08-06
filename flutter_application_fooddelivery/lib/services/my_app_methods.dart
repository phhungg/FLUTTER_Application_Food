import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';

class MyAppMethods {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    required Function fct,
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AssetsManager.warning,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SubtitleText(
                    label: subtitle,
                    fw: FontWeight.w600,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          fct();
                        },
                        child: const SubtitleText(
                          label: "OK",
                          color: Colors.red,
                        ),
                      ),
                      Visibility(
                        visible: !isError,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: SubtitleText(
                            label: "Cancel",
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> imagePicker({
    required BuildContext context,
    required Function cameraFct,
    required Function galleryFct,
    required Function removeFct,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: TitleText(
                label: "Choose options",
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: const Text("Camera"),
                    icon: Icon(Icons.camera),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: const Text("Gallery"),
                    icon: Icon(Icons.image),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: const Text("Remove"),
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

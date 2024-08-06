import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidgets extends StatelessWidget {
  final XFile? pickerImage;
  final Function function;
  const ImagePickerWidgets({
    super.key,
    this.pickerImage,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: pickerImage == null
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                  )
                : Image.file(
                    File(
                      pickerImage!.path,
                    ),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
            child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.red,
          child: InkWell(
            splashColor: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              function();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ))
      ],
    );
  }
}

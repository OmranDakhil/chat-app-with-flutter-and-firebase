import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_me/core/util/pick_image_from_enum.dart';
class PickImageWidget extends StatelessWidget {
  final PickImageFrom pickImageFrom;
  final void Function(File? image) onPick;
  const PickImageWidget({Key? key, required this.pickImageFrom, required this.onPick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var picked = await ImagePicker()
            .pickImage(source:pickImageFrom==PickImageFrom.camera?ImageSource.camera:ImageSource.gallery);
        if (picked != null) {
          onPick(File(picked.path));
          Navigator.of(context).pop();
        }
      },
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                pickImageFrom==PickImageFrom.camera?Icons.camera:Icons.photo_outlined,
                size: 30,
              ),
              SizedBox(width: 20),
              Text(
                pickImageFrom==PickImageFrom.camera?"From Camera":"From Gallery",
                style: TextStyle(fontSize: 20),
              )
            ],
          )),
    );
  }
}

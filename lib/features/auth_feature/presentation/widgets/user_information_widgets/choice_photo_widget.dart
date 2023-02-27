import 'dart:io';

import 'package:flutter/material.dart';

class ChoicePhotoWidget extends StatefulWidget {
  final String? imageUrl;
  const ChoicePhotoWidget({Key? key,  this.imageUrl}) : super(key: key);

  @override
  State<ChoicePhotoWidget> createState() => _ChoicePhotoWidgetState();
}

class _ChoicePhotoWidgetState extends State<ChoicePhotoWidget> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: _image == null
              ? AssetImage('images/user.png')
              : Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ).image,
          // backgroundImage: _image == null ? AssetImage('assets/logo2.png'):AssetImage(),
          radius: 80,
        ),
        // GestureDetector(
        //     onTap: () => showBottomSheet(context),
        //     child: Icon(Icons.camera_alt))
      ],
    );
  }
}

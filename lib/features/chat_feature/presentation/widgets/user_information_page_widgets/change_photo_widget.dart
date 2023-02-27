import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_me/core/util/pick_image_from_enum.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/user_information_page_widgets/pick_image_widget.dart';

import '../../bloc/profile_bloc/profile_bloc.dart';

class ChangePhotoWidget extends StatelessWidget {
  final String? imageUrl;
  const ChangePhotoWidget({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, current) {
          return current is PhotoChangedState;
        }, builder: (context, state) {
          if (state is PhotoChangedState) {
            return CircleAvatar(
              backgroundImage: Image.file(
                state.newImage,
                fit: BoxFit.cover,
              ).image,
              // backgroundImage: _image == null ? AssetImage('assets/logo2.png'):AssetImage(),
              radius: 80,
            );
          } else {
            return CircleAvatar(
              backgroundImage: imageUrl == null
                  ? const AssetImage('images/user.png')
                  : NetworkImage(imageUrl!) as ImageProvider,
              radius: 80,
            );
          }
        }),
        GestureDetector(
            onTap: () => showBottomSheet(context),
            child: Icon(Icons.camera_alt))
      ],
    );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(20),
              height: 180,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please Choose Image",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    PickImageWidget(
                        pickImageFrom: PickImageFrom.camera,
                        onPick: (image) {
                          onPick(image!, context);
                        }),
                    PickImageWidget(
                        pickImageFrom: PickImageFrom.gallery,
                        onPick: (image) {
                          onPick(image!, context);
                        })
                  ]));
        });
  }

  void onPick(File image, BuildContext context) {
    // implement this function
    // add event to profileBloc
    BlocProvider.of<ProfileBloc>(context).add(ChangePhotoEvent(image: image));
  }
}

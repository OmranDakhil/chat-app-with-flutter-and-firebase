import 'package:flutter/material.dart';

import '../../../../../core/widgets/my_button.dart';
import '../../../domain/entities/user_entity.dart';
import 'change_name_or_about_widget.dart';
import 'change_photo_widget.dart';
class ProfileWidget extends StatelessWidget {
  final MyUser? user;
  const ProfileWidget({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Column(
            children: [
              ChangePhotoWidget(
                  imageUrl: user != null ? user!.userImageUrl : null),
              ChangeNameOrAboutWidget(
                isName: true,
                nameOrAbout: user != null ? user!.publicName : null,
              ),
              ChangeNameOrAboutWidget(
                isName: false,
                nameOrAbout: user != null ? user!.about : null,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                        text: "continue",
                        color: Colors.blueGrey,
                        onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

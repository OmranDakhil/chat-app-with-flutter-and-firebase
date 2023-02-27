import 'package:flutter/material.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/input_message_widget.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/text_message_item_Widget.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/chat_app_bar_widget.dart';

import '../core/widgets/my_button.dart';
import '../features/chat_feature/presentation/widgets/user_information_page_widgets/change_name_or_about_widget.dart';
import '../features/chat_feature/presentation/widgets/user_information_page_widgets/change_photo_widget.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const ChatAppBarWidget(
              user: MyUser(
                  userImageUrl: null,
                  phoneNumber: '..',
                  publicName: 'omran',
                  about: 'omran'),
              nameInDevice: 'omran'),
          body:
      Column(
      children:  [
          Text('omran'),
        Text('omran'),
        Text('omran'),
        Expanded(child: Container(

        ),

        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                  text: "continue",
                  color: Colors.blueGrey,
                  onPressed: () {

                  }),
            ],
          ),
        )

      ],
    ),

    ));
  }
}

import 'package:flutter/material.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/text_message_item_Widget.dart';

import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/text_message_entity.dart';
class ListMessagesWidget extends StatelessWidget {

  final Stream<List<TextMessageEntity>>  listOfMessages;
  const ListMessagesWidget({Key? key, required this.listOfMessages}) : super(key: key);

  @override
  Widget build(BuildContext context) {


      return StreamBuilder(
        stream: listOfMessages,
        builder: (context, AsyncSnapshot<List<TextMessageEntity>> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) {
            return const LoadingWidget();
          }
          else {
            return
             ListView.builder(

                itemBuilder: (context, index) {
                return TextMessageItemWidget(message: snapshot.data![index]);
                },

                itemCount: snapshot.data!.length,
            reverse: true,
            );
          }

        });


  }
}

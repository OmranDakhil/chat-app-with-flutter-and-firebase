import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_to_show_entity.dart';

import '../../pages/chat_contact_page.dart';

class ChatsWidget extends StatelessWidget {
  final Stream<List<ChatToShowEntity>> chats;
  const ChatsWidget({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot<List<ChatToShowEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var data = snapshot.data!;
                return ListTile(
                  title: Text(data[index].nameInDevice),
                  subtitle: Text(data[index].lastMessage),
                  leading: Image(
                    image: data[index].user.userImageUrl == null
                        ? AssetImage('images/user.png')
                        : CachedNetworkImageProvider( data[index].user.userImageUrl!,


                          ) as ImageProvider,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ChatContactPage(
                              nameInDevice: data[index].nameInDevice,
                              user: data[index].user,
                            )));
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
              itemCount: snapshot.data!.length);
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';

class ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height = 80;
  final String nameInDevice;
  final MyUser user;
  const ChatAppBarWidget(
      {Key? key, required this.nameInDevice, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textHeading = const TextStyle(
        color: Colors.grey, fontSize: 20); // Text style for the name
    var textStyle = const TextStyle(
        color: Colors.white38); // Text style for everything else
    double width =
        MediaQuery.of(context).size.width; // calculate the screen width

     return Material(
          child: Container(
              decoration: const BoxDecoration(boxShadow: [
                //adds a shadow to the appbar
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                )
              ]),
              child: Container(
                  color: Colors.teal,
                  child: Row(children: <Widget>[
                    Expanded(
                        //we're dividing the appbar into 7 : 3 ratio. 7 is for content and 3 is for the display picture.
                        flex: 7,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                                height: 75 - (width * .06),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          size: 20,
                                        )),
                                    const Expanded(
                                        flex: 2,
                                        child: Center(
                                            child: Icon(
                                          Icons.attach_file,
                                          color: Colors.grey,
                                        ))),
                                    Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(nameInDevice,
                                                style: textHeading),
                                            Text(user.publicName,
                                                style: textStyle)
                                          ],
                                        )),
                                  ],
                                )),
                          ],
                        ))),
                    //This is the display picture
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: CircleAvatar(
                          radius: (80 - (width * .06)) / 2,
                          backgroundImage: user.userImageUrl == null
                              ? const AssetImage('images/user.png')
                              : CachedNetworkImageProvider( user.userImageUrl!,)
                                  as ImageProvider,
                        ))),
                  ]))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

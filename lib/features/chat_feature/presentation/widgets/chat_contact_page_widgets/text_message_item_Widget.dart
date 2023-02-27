import 'package:flutter/material.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
class TextMessageItemWidget extends StatelessWidget {
  final TextMessageEntity message;
  const TextMessageItemWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment:
        message.isSender?MainAxisAlignment.end:MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color: message.isSender?Color(0xFF1B97F3):Color(0xFFE8E8EE),
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(right: 10.0),
            child: Text(
              message.message,
              style: TextStyle(color: message.isSender?Colors.white:Colors.black),
            ),
          )
        ], // aligns the chatitem to right end
      ),
    );
  }
}

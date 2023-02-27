import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';

class InputMessageWidget extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  final String phoneNumber;
  InputMessageWidget({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.white,
              child:  Container(
                margin:  EdgeInsets.symmetric(horizontal: 1.0),
                  child: Icon(Icons.face_outlined,color: Colors.grey,),


              ),
            ),
          ),
          // Text input
          Flexible(
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 15.0),
              controller: textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),

          // Send Message Button
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: ()=>sendMessage(context),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],

      ),

    );
  }

  void sendMessage(BuildContext context) {

    String message=textEditingController.text;
    if(message.trim().isNotEmpty)
      {

        final messageEntity=TextMessageEntity(isSender: true, message: message);
        BlocProvider.of<ChatBloc>(context)
            .add(SendMessageEvent(userName: phoneNumber, message: messageEntity));
        textEditingController.text="";
      }

  }
}

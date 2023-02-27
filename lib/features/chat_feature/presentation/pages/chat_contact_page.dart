import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/strings/failures.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/chat_app_bar_widget.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/chat_contact_page_widgets/list_messages_widget.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/user_entity.dart';
import '../widgets/chat_contact_page_widgets/input_message_widget.dart';

class ChatContactPage extends StatelessWidget {
  final String nameInDevice;
  final MyUser user;
  const ChatContactPage(
      {Key? key, required this.nameInDevice, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context)
        .add(GetAllMessagesToChatEvent(userName: user.phoneNumber));
    return SafeArea(
      child: Scaffold(
        appBar:  ChatAppBarWidget(nameInDevice: nameInDevice, user: user),

        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: <Widget>[
      Column(
        children: <Widget>[
          Flexible(
            child: BlocConsumer<ChatBloc, ChatState>(buildWhen: (pre, _) {
              return pre is! AllMessagesLoaded;
            }, builder: (context, state) {
              if (state is AllMessagesLoaded) {
                return ListMessagesWidget(listOfMessages: state.messages);
              }
              if (state is ErrorInChatContactPageState &&
                  state.message == Chat_NOT_FOUND_MESSAGE) {
                return Container();
              }
              return const LoadingWidget();
            }, listener: (context, state) {
              if (state is ErrorInChatContactPageState &&
                  state.message != Chat_NOT_FOUND_MESSAGE) {
                SnakBarMessage()
                    .showErrorSnakbar(context: context, message: state.message);
              }
            }),
          ), //Chat list

          InputMessageWidget(phoneNumber: user.phoneNumber), // The input widget
        ],
      ),
    ]);
  }
}

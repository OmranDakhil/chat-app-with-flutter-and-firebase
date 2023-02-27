import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/strings/failures.dart';
import 'package:text_me/core/util/dialog_box.dart';
import 'package:text_me/core/util/snackbar_message.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../widgets/chats_page_widgets/chats_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(GetAllChatsEvent());
    return Scaffold(
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.message),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ChatBloc, ChatState>(buildWhen: (previous, current) {
      return current is ChatsLoaded;
    }, builder: (context, state) {
      // if (state is loadingChatState) return const LoadingWidget();
      if (state is ChatsLoaded) {
        return ChatsWidget(chats: state.chats);
      }
      // } else
      return const LoadingWidget();
    }, listener: (context, state) {
      if (state is ErrorInChatPageState && state.message != OFFLINE_FAILURE_MESSAGE) {
        SnakBarMessage()
            .showErrorSnakbar(context: context, message: state.message);
      }
      if (state is ErrorInChatPageState && state.message == OFFLINE_FAILURE_MESSAGE) {
        DialogBox().showOfflineDialog(() {
          BlocProvider.of<ChatBloc>(context).add(GetAllChatsEvent());
          Navigator.of(context).pop();
        }, context);
      }
    });
  }
}

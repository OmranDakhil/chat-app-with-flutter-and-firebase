import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/util/snackbar_message.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/pages/chat_contact_page.dart';

import '../widgets/contacts_page_widgets/contacts_widget.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(GetAllContactsEvent());
    return Scaffold(

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ChatBloc,ChatState>(buildWhen:(previous, current)  {
      return current is ContactsLoaded;
    },builder: (context, state) {


      if (state is ContactsLoaded) {
        if (state.contacts == null) {
          return const Center(
            child: Text("the app doesn't have the permission"),
          );
        } else {
          return ContactsWidget(contacts: state.contacts!);
        }
      } else {
        return const LoadingWidget();
      }
    }, listener: (context, state) {
      if (state is UserLoaded) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatContactPage(
                  nameInDevice: state.nameInDevice,
                  user: state.user,
                )));
      } else if (state is ErrorInContactsPageState) {
        Navigator.of(context).pop();
        SnakBarMessage()
            .showErrorSnakbar(context: context, message: state.message);
      }
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("جهات الاتصال"),
    );
  }
}

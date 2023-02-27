import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/util/dialog_box.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';

import '../../../domain/entities/contact_entity.dart';
class ContactsWidget extends StatelessWidget {
  final List<Contact> contacts;
  const ContactsWidget({Key? key,required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(


        itemBuilder: (context, index) {
          return ListTile(

            title: Text(contacts[index].Name),
            subtitle: Text(contacts[index].PhoneNumber),
            leading: Image(image: AssetImage("images/user.png")),
            onTap: (){

              BlocProvider.of<ChatBloc>(context).add(GetUserEvent(contact: contacts[index]));
              DialogBox().showLoadingDialog(context);
            },
          );


    },

        separatorBuilder: (context, index) => const Divider(
      thickness: 1,
    ),
        itemCount: contacts.length);
  }


}

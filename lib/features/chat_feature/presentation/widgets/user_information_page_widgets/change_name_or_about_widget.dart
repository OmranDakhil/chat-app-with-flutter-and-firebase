import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/profile_bloc/profile_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';

class ChangeNameOrAboutWidget extends StatelessWidget {
  final String? nameOrAbout;
  final bool isName;
  const ChangeNameOrAboutWidget(
      {Key? key, this.nameOrAbout, required this.isName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child:
                    Icon(isName ? Icons.account_circle : Icons.account_balance),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isName ? "public name" : "About",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                      buildWhen: (_, currentState) {
                    return currentState is AboutChangedState && !isName||
                        currentState is PublicNameChangedState && isName;
                  }, builder: (context, state) {
                    if (state is PublicNameChangedState ) {
                      return Text(state.newPublicName);
                    }
                    if (state is AboutChangedState ) {
                      return Text(state.newAbout);
                    } else {
                      return Text(nameOrAbout != null
                          ? nameOrAbout!
                          : (isName ? "user" : "I'm a new user"));
                    }
                  })
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => showChangeNameOrAboutSheet(context),
                  icon: Icon(Icons.edit))
            ],
          )
        ],
      ),
    );
  }

  showChangeNameOrAboutSheet(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 180,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(isName ? "public name" : "About",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                TextField(
                  controller: textEditingController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (textEditingController.text.trim().isNotEmpty) {
                            BlocProvider.of<ProfileBloc>(context).add(isName
                                ? ChangePublicNameEvent(
                                    newName: textEditingController.text)
                                : ChangeAboutEvent(
                                    newAbout: textEditingController.text));
                            Navigator.of(context).pop();
                            //add event
                          }
                        },
                        child: const Text("Save"))
                  ],
                )
              ],
            ),
          );
        });
  }
}

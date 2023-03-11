import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/util/dialog_box.dart';
import 'package:text_me/features/auth_feature/presentation/pages/welcome_page.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/pop_up_menu_bloc/pop_up_menu_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/pages/chats_page.dart';
import 'package:text_me/features/chat_feature/presentation/pages/contacts_page.dart';
import 'package:text_me/features/chat_feature/presentation/pages/user_information_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65.0),
            child: _buildAppBar(),
          ),
          body: BlocConsumer<PopUpMenuBloc, PopUpMenuState>(
            builder: (context, state) {
              return const TabBarView(
                children: [
                  ContactsPage(),
                  ChatsPage(),
                ],
              );
            },
            listener: (context, state) {
              Navigator.of(context).pop();
              if (state is ProfileLoadedState) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => UserInformationPage(
                          user: state.profile,
                      withButton: false,
                        )));
              }
              if (state is LogOutSuccessState) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const WelcomePage()),
                  (route) => false,
                );
              }
            },
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        PopupMenuButton(
            color: Colors.blueGrey,
            itemBuilder: ((context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: TextButton(
                    child: const Text("My Account"),
                    onPressed: () {
                      BlocProvider.of<PopUpMenuBloc>(context)
                          .add(GetMyProfileEvent());
                      DialogBox().showLoadingDialog(context);
                    },
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: TextButton(
                      onPressed: () {
                        DialogBox().showConfirmLogOutDialog(
                            context: context,
                            ifNo: () {
                              Navigator.of(context).pop();
                            },
                            ifYes: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<PopUpMenuBloc>(context)
                                  .add(LogOutEvent());
                              DialogBox().showLoadingDialog(context);
                            });
                      },
                      child: const Text("sign out ")),
                ),
              ];
            }))
      ],
      title: Row(
        children: [
          const Expanded(
            child: Text(
              'text me',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(
                  Icons.camera_alt,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: const TabBar(
        tabs: [
          Text("جهات الاتصال",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
          Text("الدردشات",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: Colors.black)),
        ],
      ),
    );
  }
}

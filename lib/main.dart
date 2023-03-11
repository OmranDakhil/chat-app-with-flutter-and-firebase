import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:text_me/features/auth_feature/presentation/pages/welcome_page.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/pop_up_menu_bloc/pop_up_menu_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/pages/home_page.dart';
import 'features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'features/chat_feature/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CountryCodes.init();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => di.sl<AuthBloc>(),
          ),
          BlocProvider<ChatBloc>(
            create: (context) => di.sl<ChatBloc>(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => di.sl<ProfileBloc>(),
          ),
          BlocProvider<PopUpMenuBloc>(
            create: (context) => di.sl<PopUpMenuBloc>(),
          ),
        ],
        child:   MaterialApp(
            title: "Text me",
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser!=null?const HomePage():const WelcomePage()));
  }
}

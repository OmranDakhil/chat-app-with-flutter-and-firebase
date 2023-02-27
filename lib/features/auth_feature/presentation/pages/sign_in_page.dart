import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:text_me/core/util/snackbar_message.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/auth_feature/presentation/widgets/sign_in_page_widgets/form_number_widget.dart';
import 'package:text_me/features/auth_feature/presentation/widgets/sign_in_page_widgets/sign_in_widget.dart';
import 'package:text_me/myWidget/alert.dart';
import 'package:text_me/core/widgets/my_button.dart';

import 'package:text_me/features/auth_feature/presentation/pages/otp_verfication_page.dart';

import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("اهلا بك في تطبيق راسلني",
            style: TextStyle(color: Colors.deepPurple)),
        backgroundColor: Colors.grey,
      );

  Widget _buildBody() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          SnakBarMessage()
              .showSucessSnakbar(context: context, message: state.message);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OtpVerificationPage(
                    verifyId: state.verificationId,phoneNumber: state.phoneNumber,
                  )));
        }
        if (state is ErrorAuthState) {
          SnakBarMessage()
              .showErrorSnakbar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingState)
          return LoadingWidget();
        else
          return SignInWidget();
      },
    );
  }
}

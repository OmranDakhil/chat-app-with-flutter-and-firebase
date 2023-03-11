import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat_feature/presentation/pages/user_information_page.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/otp_verificatio_page_widgets/otp_verification_form_widget.dart';
class OtpVerificationPage extends StatelessWidget {
  final String verifyId;
  final String phoneNumber;
  const OtpVerificationPage({Key? key, required this.verifyId, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body:_buildBody(),

    );
  }

  AppBar _buildAppBar() =>AppBar(
    title: Text("اهلا بك في تطبيق راسلني",
        style: TextStyle(color: Colors.deepPurple)),
    backgroundColor: Colors.grey,
  );

  Widget _buildBody() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          SnakBarMessage()
              .showSucessSnakbar(context: context, message: state.message);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const UserInformationPage(withButton: true,)));
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
          return OtpVerficationFormWidget(phoneNumber: phoneNumber,verficationId: verifyId,);
      },
    );
  }
}


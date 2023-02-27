import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
class OTPTextField extends StatelessWidget {
  final String verficationId;
  const OTPTextField({Key? key, required this.verficationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(


      maxLength: 6,
      autocorrect: true,
      onChanged: (otp) async {
        if (otp.length == 6) {
            send_otp_to_firebase(otp, context);
        }
      },
      keyboardType: TextInputType.number,
      style: TextStyle(letterSpacing: 30, fontSize: 30),
      textAlign: TextAlign.center,
    );
  }

  void send_otp_to_firebase(String otp,BuildContext context){
    BlocProvider.of<AuthBloc>(context).add(verifyOTPEvent(OTP: otp,verifyId: verficationId));
  }
}

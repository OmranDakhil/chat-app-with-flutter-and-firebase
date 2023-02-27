import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
class ResendOTPBtnWidget extends StatelessWidget {
  final String phoneNumber;
  const ResendOTPBtnWidget({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ArgonTimerButton(
        initialTimer: 60, // Optional
        height: 50,
        width: MediaQuery.of(context).size.width * 0.45,
        minWidth: MediaQuery.of(context).size.width * 0.30,
        color: Color(0xFF7866FE),
        borderRadius: 5.0,
        child: Text(
          "اعادة ارسال الكود",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        loader: (timeLeft) {
          return Text(
            "Wait | $timeLeft",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          );
        },
        onTap: (startTimer, btnState) {
          if (btnState == ButtonState.Idle) {
            startTimer(60);
            BlocProvider.of<AuthBloc>(context)
                .add(SignInEvent(phoneNumber: phoneNumber));

          }
        },
      ),
    );
  }
}

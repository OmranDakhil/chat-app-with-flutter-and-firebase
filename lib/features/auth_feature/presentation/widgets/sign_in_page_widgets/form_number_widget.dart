import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:text_me/features/auth_feature/presentation/bloc/auth_bloc.dart';

import '../../../../../core/widgets/my_button.dart';


class FormNumberWidget extends StatelessWidget {
  GlobalKey<FormState> numberState = GlobalKey<FormState>();
  String phoneNumber="";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: numberState,
      child: Column(
        children: [
          IntlPhoneField(

            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            onSaved:(phone) {
              phoneNumber=phone!.completeNumber;
              print(phone.completeNumber);
            },
            initialCountryCode: 'SY',
          ),
          SizedBox(
            height: 20,
          ),
          MyButton(
              text: "تسجيل الرقم",
              color: Colors.blue,
              onPressed: () => _validateThenSignIn(context)),
        ],
      ),
    );
  }

  void _validateThenSignIn(BuildContext context) {
    var numberdata = numberState.currentState!;
    numberdata.save();
    if (numberdata.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(SignInEvent(phoneNumber: phoneNumber));
    }
  }
}

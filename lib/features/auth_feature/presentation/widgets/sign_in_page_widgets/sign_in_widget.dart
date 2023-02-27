import 'package:flutter/material.dart';

import 'form_number_widget.dart';
class SignInWidget extends StatelessWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          "images/logo.png",
          height: 180,
        ),
        Center(
            child: Text(
              "الرجاء ادخال رقمك مع رمز دولتك ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            )
        ),
        FormNumberWidget()

      ],
    );
  }
}

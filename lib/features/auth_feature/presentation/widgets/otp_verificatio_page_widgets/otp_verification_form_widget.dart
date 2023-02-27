import 'package:flutter/material.dart';

import 'otp_text_field.dart';
import 'resend_otp_btn_widget.dart';
class OtpVerficationFormWidget extends StatelessWidget {
  final String phoneNumber;
  final String verficationId;
  const OtpVerficationFormWidget({Key? key, required this.phoneNumber, required this.verficationId}) : super(key: key);

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
        Column(
          children: [
            Text("تم ارسال كود التفعبل الى الرقم"),
            SizedBox(
              height: 5,
            ),
            Text(
              phoneNumber,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            )
          ],
        ),
        Center(
            child: Text(
              "الرجاء ادخال الكود الخاص بك ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            )),
        OTPTextField(verficationId: verficationId),
        SizedBox(
          height: 20,
        ),
        ResendOTPBtnWidget(phoneNumber:phoneNumber),

      ],
    );
  }
}

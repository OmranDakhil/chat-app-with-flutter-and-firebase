import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50, child: Center(child: CircularProgressIndicator())),
        );
      });
}
showErrorDialog(context,message){
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(color: Colors.red, width: 2),
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      showCloseIcon: true,
      title: "خطأ",
      desc: message,
  );
}

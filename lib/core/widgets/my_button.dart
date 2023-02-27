import 'package:flutter/material.dart';
// ignore: must_be_immutable
class MyButton extends StatelessWidget {

  MyButton({Key? key, required this.text,required this.color,required this.onPressed}) : super(key: key) ;
  String text;
  Color color ;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: MaterialButton(

        child: Text(text,
          style: TextStyle(color: Colors.white),
        ),
          onPressed: onPressed),
    );
  }
}

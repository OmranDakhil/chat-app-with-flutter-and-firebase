import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
            height:30,
            width: 30,

              child: CircularProgressIndicator(
                strokeWidth: 3,

                value: 0.6,
                backgroundColor: Colors.blueAccent,
              ),
            ),
      ),
    );
  }
}

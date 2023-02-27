import 'package:flutter/material.dart';

class DialogBox {
  showLoadingDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('loading ...')
                ],
              ),
            ),
          );
        });
  }

  showOfflineDialog(Function() onPressed, BuildContext context) {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'ERROR',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: const Text('check your internet connection'),
            actions: [
              ElevatedButton(
                  onPressed: onPressed, child: const Text('try again'))
            ],
          );
        });
  }
}

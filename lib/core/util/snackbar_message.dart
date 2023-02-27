import 'package:flutter/material.dart';

class SnakBarMessage
{
  showSucessSnakbar({required BuildContext context,required String message})
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,
            style: const TextStyle(color: Colors.white
            )
        ),
          backgroundColor: Colors.green,)
    );
  }
  showErrorSnakbar({required BuildContext context,required String message})
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,
            style: const TextStyle(color: Colors.white
            )
        ),
          backgroundColor: Colors.redAccent,)
    );
  }
}
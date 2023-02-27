import 'package:flutter/material.dart';
import 'package:text_me/features/auth_feature/presentation/pages/sign_in_page.dart';
import 'package:text_me/myWidget/alert.dart';
import 'package:text_me/core/widgets/my_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("images/logo.png", height: 200),
          const SizedBox(
            height: 8,
          ),
          const Center(
              child: Text("اهلا بكم في تطبيق راسلني",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
          const SizedBox(
            height: 50,
          ),
          MyButton(
              text: "هيا لنبدأ",
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignInPage()));
              })
        ],
      ),
    );
  }
}

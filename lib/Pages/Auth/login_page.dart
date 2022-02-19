import 'package:flutter/material.dart';

import 'package:sit_volleyball_app/Pages/Auth/button_apple.dart';
import 'package:sit_volleyball_app/Pages/Auth/button_mail.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            MailButton(),
            SizedBox(height: 20,),
            AppleButton(),
          ],
        ),
      ),
    );
  }
}

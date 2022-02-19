import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Widgets/normal_text_field.dart';
import 'package:sit_volleyball_app/Pages/Auth/Mail/mail_register_button.dart';
import 'package:sit_volleyball_app/Pages/Auth/Mail/mail_login_button.dart';

class MailLoginPage extends StatefulWidget {
  const MailLoginPage({Key? key}) : super(key: key);

  @override
  MailLoginPageState createState() => MailLoginPageState();
}

class MailLoginPageState extends State<MailLoginPage> {

  final mailController = TextEditingController();
  final passController = TextEditingController();
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isRegister
                  ? TextButton(
                    child: const Text('ログイン'),
                    onPressed: (){
                      setState(() {
                        isRegister = false;
                      });
                    },
                  )
                  : TextButton(
                    child: const Text('新規登録'),
                    onPressed: (){
                      setState(() {
                        isRegister = true;
                      });
                    },
                  ),
              ],
            ),
            NormalTextField(
              controller: mailController,
              hint: 'mail@address.com',
              label: 'mail',
            ),
            const SizedBox(height: 10),
            NormalTextField(
              controller: passController,
              hint: 'password',
              label: 'password',
            ),
            const SizedBox(height: 10),
            isRegister
                ? MailRegisterButton(mailController, passController)
                : LoginButton(mailController, passController),
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
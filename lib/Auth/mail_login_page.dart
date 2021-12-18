import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Auth/register_page.dart';
import '/Widgets/normal_text_field.dart';
import '/Widgets/normal_alert_dialog.dart';

class MailLoginPage extends StatelessWidget {

  MailLoginPage({Key? key}) : super(key: key);

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
                TextButton(
                  child: const Text('新規登録'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ],
            ),
            NormalTextField(
              controller: mailController,
              hint: 'mail',
              label: 'mail',
            ),
            const SizedBox(height: 10),
            NormalTextField(
              controller: passController,
              hint: 'password',
              label: 'password',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () async {
                try{
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: mailController.text,
                    password: passController.text,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ログイン成功！'))
                  );
                }on FirebaseAuthException catch(e){
                  if(e.code == 'wrong-password'){
                    NormalAlertDialog(context,'パスワードが違います');
                  }else if(e.code == 'user-not-found') {
                    NormalAlertDialog(context, '未登録のアドレスです');
                  }
                }catch (e){
                  NormalAlertDialog(context,'$e.code');
                }

              }
            ),
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

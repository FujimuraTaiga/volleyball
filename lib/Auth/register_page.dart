import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';

class RegisterPage extends StatelessWidget {

  RegisterPage({Key? key}) : super(key: key);

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
            TextField(
              controller: mailController,
              decoration: const InputDecoration(
                hintText: 'mail',
                labelText: 'mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: 'password',
                labelText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('登録'),
              onPressed: () async {
                /*register*/
                try{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: mailController.text,
                    password: passController.text,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('登録完了！'))
                  );
                } on FirebaseAuthException catch(e){
                  if(e.code == 'invalid-email'){
                    NormalAlertDialog(context,'メールアドレスが正しくありません');
                  }else if(e.code == 'email-already-in-use'){
                    NormalAlertDialog(context,'既に登録されています。');
                  }else if(e.code == 'weak-password'){
                    NormalAlertDialog(context,'パスワードは6文字以上にしてください');
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

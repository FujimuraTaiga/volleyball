import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';

class MailRegisterButton extends StatelessWidget {

  final TextEditingController mailController;
  final TextEditingController passController;
  final bool? isRegister;

  const MailRegisterButton(this.mailController, this.passController,{Key? key, this.isRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('登録'),
        onPressed: () async {
          /*register*/
          try{
            final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: mailController.text,
              password: passController.text,
            );
            UserOperation.addUser(result.user!.uid, 'UserName', '');

            Navigator.popUntil(context, (route) => route.isFirst);
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
            }else{
              NormalAlertDialog(context,e.code);
            }
          }
        }
    );
  }
}

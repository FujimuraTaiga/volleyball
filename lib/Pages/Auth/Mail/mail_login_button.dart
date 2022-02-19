import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';

class LoginButton extends StatelessWidget {

  final TextEditingController mailController;
  final TextEditingController passController;

  const LoginButton(this.mailController,this.passController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
            }else if(e.code == 'invalid-email'){
              NormalAlertDialog(context, 'アドレスの形式が違います');
            }else{
              NormalAlertDialog(context, e.code);
            }
          }catch (e){
            NormalAlertDialog(context,'$e.code');
          }
        }
    );
  }
}

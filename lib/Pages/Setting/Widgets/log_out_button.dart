import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {

  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: const Text('ログアウト'),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}

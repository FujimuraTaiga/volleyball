import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/user.dart';

class DeleteAccountDialog extends StatelessWidget {

  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserOperation>(context);

    return AlertDialog(
      title: const Text('本当に削除しますか？'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
                child: const Text('削除'),
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser!;
                  await userData.delete(user.uid);
                  await user.delete();
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ],
    );
  }
}

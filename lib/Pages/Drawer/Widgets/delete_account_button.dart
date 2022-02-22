import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/Drawer/Widgets/delete_account_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: const Text('アカウント削除'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const DeleteAccountDialog(),
          );
        },
      ),
    );
  }
}

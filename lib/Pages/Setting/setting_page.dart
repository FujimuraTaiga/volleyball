import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('ログアウト'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
            child: const Text('アカウント削除'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('本当に削除しますか？'),
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
                              await FirebaseAuth.instance.currentUser!.delete();
                              Navigator.pop(context);
                            }
                          ),
                        ],
                      ),
                    ],
                  );
                }
              );
            },
          ),
        ],
      ),
    );
  }
}

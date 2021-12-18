import 'package:flutter/material.dart';

class DeleteUserDialog{
  final BuildContext context;

  DeleteUserDialog(this.context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('本当に削除しますか？'),
            actions: [
              TextButton(
                child: const Text('削除'),
                onPressed: () async => Navigator.pop(context),
              ),
            ],
          );
        }
    );
  }
}
import 'package:flutter/material.dart';

class WrongUrlDialog{
  final BuildContext context;
  WrongUrlDialog(this.context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.asset('assets/images/wrongURL.png'),
            actions: [
              TextButton(
                child: const Text('ok'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
    );
  }
}
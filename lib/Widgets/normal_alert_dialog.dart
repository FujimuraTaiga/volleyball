import 'package:flutter/material.dart';

class NormalAlertDialog {
  final BuildContext context;
  final String alert;

  NormalAlertDialog(this.context,this.alert) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(alert),
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
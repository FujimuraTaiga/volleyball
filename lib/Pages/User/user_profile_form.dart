import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:sit_volleyball_app/Widgets/normal_text_field.dart';

class UserProfileForm extends StatelessWidget {
  final nameController = TextEditingController();
  final imageController = TextEditingController();

  UserProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserOperation>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ユーザー名'),
          NormalTextField(
            controller: nameController,
            hint: user.userData.name,
          ),
          ElevatedButton(
            child: const Text('変更'),
            onPressed: () {
              user.updateName(nameController.text);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

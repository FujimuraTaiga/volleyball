import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Providers/User/user_provider.dart';
import 'package:sit_volleyball_app/Widgets/normal_text_field.dart';

class UserProfileForm extends StatelessWidget {
  final nameController = TextEditingController();
  final imageController = TextEditingController();

  UserProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ユーザー名'),
          NormalTextField(
            controller: nameController,
            hint: user.data.name,
          ),
          ElevatedButton(
            child: const Text('変更'),
            onPressed: () async {
              await user.update(nameController.text, imageController.text);
              await user.find();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

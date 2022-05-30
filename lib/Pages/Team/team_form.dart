import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/team.dart';
import 'package:sit_volleyball_app/Entity/User/user_provider.dart';
import 'package:sit_volleyball_app/Widgets/normal_text_field.dart';

class TeamForm extends StatelessWidget {
  final nameController = TextEditingController();

  TeamForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('チーム名: '),
            NormalTextField(controller: nameController),
            ElevatedButton(
              child: const Text('作成'),
              onPressed: () {
                TeamOperation().createTeam(nameController.text, user);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

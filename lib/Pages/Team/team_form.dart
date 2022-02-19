import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/Setting/Widgets/log_out_button.dart';

class TeamForm extends StatelessWidget {

  const TeamForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}

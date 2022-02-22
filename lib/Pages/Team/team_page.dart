import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:sit_volleyball_app/Pages/Team/team_form.dart';
import 'package:sit_volleyball_app/Pages/User/user_id.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserOperation>(context);
    user.find();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _header(context),
          for (Map<String, String> team in user.userData.team) ...{
            Card(
              child: Row(
                children: [
                  Text(team['name']!),
                  CopyableID(team['id']!),
                ],
              ),
            )
          }
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TeamForm()));
          },
        )
      ],
    );
  }
}

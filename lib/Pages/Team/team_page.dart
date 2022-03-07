import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Providers/User/user_provider.dart';
import 'package:sit_volleyball_app/Pages/Team/team_detail.dart';
import 'package:sit_volleyball_app/Pages/Team/team_form.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: const [
          TeamPageHeader(),
          TeamPageBody(),
        ],
      ),
    );
  }
}

class TeamPageHeader extends StatelessWidget {
  const TeamPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class TeamPageBody extends StatelessWidget {
  const TeamPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: user.data.team.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(user.data.team[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamDetail(user.data.team[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

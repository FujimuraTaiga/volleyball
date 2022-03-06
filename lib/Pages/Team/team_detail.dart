import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/team.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:sit_volleyball_app/Pages/User/user_name.dart';

class TeamDetail extends StatelessWidget {
  final String teamId;

  const TeamDetail(this.teamId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.directions_run,
                semanticLabel: '退会',
              ),
              onPressed: () {
                TeamOperation().quitTeam(teamId);
                user.delTeam(teamId);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const Text(
              'メンバー',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TeamMember(teamId),
          ],
        ));
  }
}

class TeamMember extends StatelessWidget {
  final String teamId;

  const TeamMember(this.teamId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Team')
            .doc(teamId)
            .collection('Member')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      UserName(doc.get('name')),
                      Text(doc.get('id')),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}

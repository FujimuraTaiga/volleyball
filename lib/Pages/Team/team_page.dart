import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Entity/team.dart';
import 'package:sit_volleyball_app/Pages/Team/team_form.dart';

class TeamPage extends StatelessWidget {

  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _header(context),
          Expanded(child: _teamList(context)),
        ],
      ),
    );
  }

  Widget _header(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TeamForm())
            );
          },
        )
      ],
    );
  }

  Widget _teamList(BuildContext context){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('team').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else{
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc){
              Team team = Team.readDoc(doc);
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamForm(doc: doc,))
                ),
                child: Card(
                  child: Text(
                    team.name!,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }).toList()
          );
        }
      },
    );
  }
}

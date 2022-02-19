import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/Entity/team.dart';

class TeamSelect extends StatefulWidget {

  const TeamSelect(this.controller,{Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  _TeamSelectState createState() => _TeamSelectState();
}

class _TeamSelectState extends State<TeamSelect> {

  String _selected = '芝浦工大';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('team').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        return DropdownButtonFormField(
          value: _selected,
          onChanged: (value){
            setState((){
              _selected = value as String;
              widget.controller.text = _selected;
            });
          },
          items: (snapshot.data!.docs.map((DocumentSnapshot doc){
              Team team = Team.readDoc(doc);
              return DropdownMenuItem(
                child: Text(team.name!),
                value: team.name!,
              );
            }).toList()
          ),
          decoration: const InputDecoration(
            label: Text('team'),
            border: OutlineInputBorder(),
          ),
        );
      }
    );
  }
}

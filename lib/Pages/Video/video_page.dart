import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/Video/video_form.dart';
import '/Entity/team.dart';
import 'video_card.dart';

class VideoPage extends StatefulWidget {
  
  const VideoPage({Key? key}) : super(key: key);

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage>{

  String _selected = '芝浦工大';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(),
          Expanded(child: _videoList()),
        ],
      ),
    );
  }

  Widget _dropdownButton(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('team').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return DropdownButton(items: const [],);
        }
        return DropdownButton(
          value: _selected,
          onChanged: (value){
            setState(() {
              _selected = value as String;
            });
          },
          items: snapshot.data!.docs.map((DocumentSnapshot doc){
            Team team = Team.readDoc(doc);
            return DropdownMenuItem(
              child: Text(team.name!),
              value: team.name!,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _dropdownButton(),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VideoForm())
            );
          },
        ),
      ],
    );
  }

  Widget _videoList(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('videos')
          .where('team',isEqualTo: _selected)
          .orderBy('date',descending: true)
          .orderBy('set',descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else{
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc){
              return VideoCard(doc: doc);
            }).toList(),
          );
        }
      },
    );
  }
}
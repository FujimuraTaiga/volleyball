import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/Video/video_card.dart';

class VideoPageAfter extends StatefulWidget {
  const VideoPageAfter({Key? key}) : super(key: key);

  @override
  _VideoPageAfterState createState() => _VideoPageAfterState();
}

class _VideoPageAfterState extends State<VideoPageAfter> {
  String _selected = '芝浦工大';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
        ),
        drawer: _drawer(),
        body: _videoList(),
      ),
    );
  }

  Widget _drawer(){
    return Drawer();
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Entity/video.dart';
import '../Video/video_form.dart';

class VideoCard extends StatelessWidget {

  const VideoCard({Key? key, required this.doc}) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Video video = Video.readDoc(doc);
    return InkWell(
      onTap: () => video.launchURL(),
      child: Card(
        child: Row(
          children: [
            Expanded(flex: 2,child: video.image()),
            Expanded(flex: 3,child: video.title()),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoForm(doc: doc))
              ),
            )
          ],
        ),
      ),
    );
  }
}

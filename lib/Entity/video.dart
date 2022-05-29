import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Video {
  DateTime? date;
  int? set;
  String? team;
  String? id;
  DateFormat formatter = DateFormat('yyyy/MM/dd');

  Video.readDoc(DocumentSnapshot doc) {
    date = doc[VideoField.date].toDate();
    set = doc[VideoField.set];
    team = doc[VideoField.team];
    id = doc[VideoField.id];
    formatURL();
  }

  Video.readController(List list) {
    date = DateTime.parse(list[0].text);
    set = int.parse(list[1].text);
    team = list[2].text;
    id = list[3].text;
  }

  Map<String, dynamic> toMap() {
    return {
      VideoField.date: date,
      VideoField.set: set,
      VideoField.team: team,
      VideoField.id: id,
    };
  }

  String dateFormat(DateTime date) {
    return formatter.format(date);
  }

  bool existBlank() {
    bool date = this.date == null;
    bool set = this.set == null;
    bool team = this.team == '';
    bool url = id == '';

    if (date || set || team || url) {
      return true;
    } else {
      return false;
    }
  }

  Widget title() {
    return Column(
      children: [
        Text(formatter.format(date!)),
        Text('vs$team $setセット目'),
      ],
    );
  }

  void formatURL() {
    if (id!.contains('youtu.be')) {
      id = id!.split('youtu.be/')[1];
    } else if (id!.contains('watch?v=')) {
      id = id!.split('v=')[1];
    }
  }

  Image image() {
    return Image.network('https://img.youtube.com/vi/${id!}/mqdefault.jpg');
  }

  String formattedURL() {
    return 'https://www.youtube.com/watch?v=${id!}';
  }

  bool validURL() {
    String url = formattedURL();
    if (url.contains('https://www.youtube.com/watch?v=') ||
        url.contains('https://youtu.be/')) {
      return true;
    }
    return Uri.parse(url).isAbsolute;
  }

  Future<void> addVideo(BuildContext context) async {
    try {
      if (validURL()) {
        final newDocument =
            FirebaseFirestore.instance.collection('videos').doc();
        await newDocument.set(toMap());
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('登録完了'),
        ));
      } else {
        NormalAlertDialog(context, 'URLが違います');
      }
    } on FirebaseException catch (e) {
      NormalAlertDialog(context, '$e.code');
    }
  }

  static void delVideo(String documentId) {
    FirebaseFirestore.instance.doc('videos/$documentId').delete();
  }

  void updateVideo(String documentId) async {
    await FirebaseFirestore.instance.doc('videos/$documentId').update({
      VideoField.date: date,
      VideoField.set: set,
      VideoField.team: team,
      VideoField.id: id,
    });
  }

  void launchURL() async {
    String url = formattedURL();
    await canLaunch(url)
        ? await launch(url, forceSafariVC: false, forceWebView: false)
        : throw 'Could not Launch URL';
  }
}

class VideoField {
  static const date = 'date';
  static const set = 'set';
  static const team = 'team';
  static const id = 'url';
}

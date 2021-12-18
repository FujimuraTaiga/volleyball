import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sit_volleyball_app/Widgets/normal_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '/Widgets/wrong_url_dialog.dart';

class Video{
  DateTime? date;
  int? set;
  String? team;
  String? url;
  DateFormat formatter = DateFormat('yyyy/MM/dd');

  Video.readDoc(DocumentSnapshot doc){
    date = doc[VideoField.date].toDate();
    set = doc[VideoField.set];
    team = doc[VideoField.team];
    url = doc[VideoField.url];
  }

  Video.readController(List list){
    date = DateTime.parse(list[0].text);
    set = int.parse(list[1].text);
    team = list[2].text;
    url = list[3].text;
  }

  Map<String,dynamic> toMap(){
    return {
      VideoField.date: date,
      VideoField.set: set,
      VideoField.team: team,
      VideoField.url: url,
    };
  }

  String dateFormat(DateTime date){
    return formatter.format(date);
  }

  bool existBlank(){
    bool date = this.date == null;
    bool set = this.set == null;
    bool team = this.team == '';
    bool url = this.url == '';

    if (date||set||team||url) {
      return true;
    } else {
      return false;
    }
  }

  Widget title(){
    return Column(
      children: [
        Text(formatter.format(date!)),
        Text('vs$team $setセット目'),
      ],
    );
  }

  void formatURL(){
    if (url!.contains('&feature=youtu.be')) {
      url = url!.substring(0, url!.length - 17);
    } else if (url!.contains('https://youtu.be/')) {
      url = 'https://www.youtube.com/watch?v=${url!.substring(17)}';
    }
  }

  Image image() {
    return Image.network('https://img.youtube.com/vi/${url!.substring(32)}/mqdefault.jpg');
  }

  bool validURL(){
    return Uri.parse(url!).isAbsolute;
  }

  Future<void> addVideo(BuildContext context) async {
    try{
      if(validURL()){
        final newDocument = FirebaseFirestore.instance.collection('videos').doc();
        await newDocument.set(toMap());
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('登録完了'),
            )
        );
      }else{
        WrongUrlDialog(context);
      }
    }on FirebaseException catch (e){
      NormalAlertDialog(context,'$e.code');
    }
  }

  static void delVideo(String documentId){
    FirebaseFirestore.instance.doc('videos/$documentId').delete();
  }

  void updateVideo(String documentId) async {
    await FirebaseFirestore.instance.doc('videos/$documentId').update({
      VideoField.date: date,
      VideoField.set: set,
      VideoField.team: team,
      VideoField.url: url,
    });
  }

  void launchURL() async {
    await canLaunch(url!) ? await launch(url!,forceSafariVC: false,forceWebView: false) : throw 'Could not Launch URL';
  }
}

class VideoField{
  static const date = 'date';
  static const set = 'set';
  static const team = 'team';
  static const url = 'url';
}
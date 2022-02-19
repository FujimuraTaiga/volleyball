import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamOperation{

  static final teamDB = FirebaseFirestore.instance.collection('Team');

  static Future<void> createTeam(String teamId, String teamName,UserData userData) async {
    await teamDB.add({
      'id'    : teamId,
      'name'  : teamName,
    });
    await teamDB.doc().collection('Member').add({
      'id'    : userData.id,
      'name'  : userData.name,
    });
  }
}

class Team{
  String? name;
  String? twitter;
  String? instagram;
  String? hp;

  Team.readDoc(DocumentSnapshot doc){
    name = doc['name'];
    twitter = doc['twitter'];
    instagram = doc['instagram'];
    hp = doc['hp'];
  }
  Team.readController(List<TextEditingController> list){
    name = list[0].text;
    twitter = list[1].text;
    instagram = list[2].text;
    hp = list[3].text;
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'twitter': twitter,
      'instagram': instagram,
      'hp': hp,
    };
  }

  Future<void> addVideo()async{
    final newDocument = FirebaseFirestore.instance.collection('team').doc();
    await newDocument.set(toMap());
  }

  static void delVideo(String documentId){
    FirebaseFirestore.instance.doc('team/$documentId').delete();
  }

  void updateVideo(String documentId) async {
    await FirebaseFirestore.instance.doc('team/$documentId').update({
      TeamField.name: name,
      TeamField.twitter: twitter,
      TeamField.instagram: instagram,
      TeamField.hp: hp,
    });
  }

  void launchURL(String url) async {
    await canLaunch(url) ? await launch(url,forceSafariVC: false,forceWebView: false) : throw 'Could not Launch URL';
  }
}

class TeamField{
  static const name = 'name';
  static const twitter = 'twitter';
  static const instagram = 'instagram';
  static const hp = 'hp';
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sit_volleyball_app/Entity/user.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamData {
  final String id;
  final String name;
  final List<Map<String, String>> member;
  TeamData(this.id, this.name, this.member);
}

class TeamOperation {
  final teamDB = FirebaseFirestore.instance.collection('Team');

  Future<void> createTeam(String teamName, UserProvider user) async {
    final team = teamDB.doc();
    team.set({
      'id': team.id,
      'name': teamName,
    });
    await teamDB.doc(team.id).collection('Member').doc(user.userData.id).set({
      'id': user.userData.id,
      'name': user.userData.name,
    });
    await user.addTeam(team.id, teamName);
  }

  Future<void> updateTeam(String teamId, String teamName) async {
    await teamDB.doc(teamId).update({
      'id': teamId,
      'name': teamName,
    });
  }

  Future<TeamData> findTeam(String teamId) async {
    final teamData =
        await teamDB.doc(teamId).get().then((DocumentSnapshot doc) {
      return TeamData(doc.id, doc.get('name'), [{}]);
    });
    await teamDB
        .doc(teamId)
        .collection('Member')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        teamData.member.add({
          'id': doc.get('id'),
          'name': doc.get('name'),
        });
      }
    });
    return teamData;
  }

  Future<List> getMember(String teamId) async {
    final List<Map<String, String>> member = [{}];
    await teamDB
        .doc(teamId)
        .collection('Member')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        member.add({
          'id': doc.get('id'),
          'name': doc.get('name'),
        });
      }
    });
    return member;
  }
}

class Team {
  String? name;
  String? twitter;
  String? instagram;
  String? hp;

  Team.readDoc(DocumentSnapshot doc) {
    name = doc['name'];
    twitter = doc['twitter'];
    instagram = doc['instagram'];
    hp = doc['hp'];
  }
  Team.readController(List<TextEditingController> list) {
    name = list[0].text;
    twitter = list[1].text;
    instagram = list[2].text;
    hp = list[3].text;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'twitter': twitter,
      'instagram': instagram,
      'hp': hp,
    };
  }

  Future<void> addVideo() async {
    final newDocument = FirebaseFirestore.instance.collection('team').doc();
    await newDocument.set(toMap());
  }

  static void delVideo(String documentId) {
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
    await canLaunch(url)
        ? await launch(url, forceSafariVC: false, forceWebView: false)
        : throw 'Could not Launch URL';
  }
}

class TeamField {
  static const name = 'name';
  static const twitter = 'twitter';
  static const instagram = 'instagram';
  static const hp = 'hp';
}

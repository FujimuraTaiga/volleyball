import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Entity/team.dart';

class UserData {
  String id;
  String name;
  String image;
  List<UserTeam> team;

  UserData(this.id, this.name, this.image, this.team);

  void set(String id, String name, String image) {
    this.id = id;
    this.name = name;
    this.image = image;
  }
}

class UserTeam {
  String id;
  String name;
  UserTeam(this.id, this.name);
}

class UserProvider extends ChangeNotifier {
  final userDB = FirebaseFirestore.instance.collection('User');
  final user = FirebaseAuth.instance.currentUser!;

  final data = UserData('', '', '', []);

  UserProvider() {
    find();
    readTeam();
  }

  Future<void> add(String name, String image) async {
    await userDB.doc(user.uid).set({
      'id': user.uid,
      'name': name,
      'image': image,
    });
    data.set(user.uid, name, image);
    notifyListeners();
  }

  Future<void> find() async {
    await userDB.doc(user.uid).get().then(((DocumentSnapshot doc) {
      data.set(doc.get('id'), doc.get('name'), doc.get('image'));
    }));
    notifyListeners();
  }

  Future<void> update(String name, String image) async {
    await userDB.doc(user.uid).update({
      'id': user.uid,
      'name': name,
      'image': image,
    });
    notifyListeners();
  }

  Future<void> delete() async {
    await userDB.doc(user.uid).collection('Team').doc().delete();
    await userDB.doc(user.uid).delete();
    await user.delete();
  }

  Future<void> addTeam(String teamId, String teamName) async {
    await userDB.doc(user.uid).collection('Team').doc(teamId).set({
      'id': teamId,
      'name': teamName,
    });
    data.team.add(UserTeam(teamId, teamName));
    notifyListeners();
  }

  Future<void> readTeam() async {
    final List<UserTeam> teams = [];
    await userDB
        .doc(user.uid)
        .collection('Team')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        teams.add(UserTeam(doc.get('id'), doc.get('name')));
      }
    });
    data.team = teams;
    notifyListeners();
  }

  Future<void> delTeam(String teamId) async {
    await userDB.doc(user.uid).collection('Team').doc(teamId).delete();
    data.team.removeWhere((UserTeam userTeam) => userTeam.id == teamId);
    if (data.team.isEmpty) {
      TeamOperation().delTeam(teamId);
    }
    notifyListeners();
  }
}

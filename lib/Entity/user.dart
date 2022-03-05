import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  String id;
  String name;
  String image;

  UserData(this.id, this.name, this.image);

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

  final userData = UserData('', '', '');
  List<UserTeam> userTeam = [];

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
    userData.set(user.uid, name, image);
    notifyListeners();
  }

  Future<void> find() async {
    await userDB.doc(user.uid).get().then(((DocumentSnapshot doc) {
      userData.set(doc.get('id'), doc.get('name'), doc.get('image'));
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
    userTeam.add(UserTeam(teamId, teamName));
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
    userTeam = teams;
    notifyListeners();
  }

  Future<void> delTeam(String teamId) async {
    await userDB.doc(user.uid).collection('Team').doc(teamId).delete();
    userTeam.removeWhere((UserTeam userTeam) => userTeam.id == teamId);
    notifyListeners();
  }
}

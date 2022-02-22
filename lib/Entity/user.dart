import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  String id;
  String name;
  String image;
  List<Map<String, String>> team;

  UserData(this.id, this.name, this.image, this.team);
}

class UserOperation extends ChangeNotifier {
  final userDB = FirebaseFirestore.instance.collection('User');

  final userData = UserData('', '', '', [{}]);

  Future<void> add(String name, String image) async {
    final user = FirebaseAuth.instance.currentUser!;
    await userDB.doc(user.uid).set({
      'id': user.uid,
      'name': name,
      'image': image,
    });
  }

  Future<void> find() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await userDB.doc(userId).get().then(((DocumentSnapshot doc) {
      userData.id = doc['id'];
      userData.name = doc['name'];
      userData.image = doc['image'];
    }));
    await userDB
        .doc(userId)
        .collection('Team')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userData.team.add({
          'id': doc.get('id'),
          'name': doc.get('name'),
        });
      }
    });
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    final user = FirebaseAuth.instance.currentUser!;
    await userDB.doc(user.uid).update({
      'name': name,
    });
    notifyListeners();
  }

  Future<void> delete() async {
    final user = FirebaseAuth.instance.currentUser!;
    await userDB.doc(user.uid).collection('Team').doc().delete();
    await userDB.doc(user.uid).delete();
    await user.delete();
  }

  Future<void> addTeam(String teamId, String teamName) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await userDB.doc(userId).collection('Team').doc(teamId).set({
      'id': teamId,
      'name': teamName,
    });
    userData.team.add({
      'id': teamId,
      'name': teamName,
    });
  }

  Future<void> delTeam(String teamId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await userDB.doc(userId).collection('Team').doc(teamId).delete();
    userData.team.removeWhere((element) => 'id' == teamId);
    notifyListeners();
  }
}

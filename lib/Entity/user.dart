import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData{
  String id;
  String name;
  String image;
  Map<String,String> team;

  UserData(this.id,this.name,this.image,this.team);
}

class UserOperation extends ChangeNotifier{

  final userDB = FirebaseFirestore.instance.collection('User');

  final userData = UserData('','','',{});

  Future<void> addUser(String id,String name,String image) async {
    if(userData.id == ''){
      await userDB.add({
        'id'    : id,
        'name'  : name,
        'image' : image,
      });
      await userDB.doc().collection('Team').add({});
    }
  }

  Future<void> findById(String userId) async {
    await userDB.get().then((QuerySnapshot querySnapshot){
      for(var doc in querySnapshot.docs){
        if(doc['id']! == userId){
          userData.id = doc['id'];
          userData.name = doc['name'];
          userData.image = doc['image'];
        }
      }
    });
    await userDB.doc().collection('Team').get().then((QuerySnapshot querySnapshot){
      for(var doc in querySnapshot.docs){
        userData.team.addAll({
          'id'    : doc['id'],
          'name'  : doc['name'],
        });
      }
    });
    notifyListeners();
  }

  Future<void> delUser(String userId) async {
    final userPath = await userDB.get().then((QuerySnapshot querySnapShot) {
      for(var doc in querySnapShot.docs){
        String path = doc.id;
        if(doc['id'] == userId){
          return path;
        }
      }
    });
    await userDB.doc(userPath).delete();
  }

  Future<void> addTeam(String userId, String teamId,String teamName) async {
    await userDB.doc(userId).collection('Team').add({
      'id' : teamId,
      'team' : teamName,
    });
  }

  Future<void> delTeam(String userId, String teamId) async {
    await userDB.doc(userId).collection('Team').doc(teamId).delete();
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sit_volleyball_app/Repository/repository.dart';
import 'package:sit_volleyball_app/Repository/User/user.dart';
import 'package:sit_volleyball_app/Repository/User/user_team.dart';
import 'package:sit_volleyball_app/Repository/User/user_repository.dart';
import 'package:sit_volleyball_app/Repository/User/user_team_repository.dart';

class UserProvider extends ChangeNotifier {
  final Repository userRepository = UserRepository();
  final Repository teamRepository = UserTeamRepository();

  final data = UserModel('', '', '', []);

  Future<void> create(String name, String image) async {
    final user = FirebaseAuth.instance.currentUser!;
    data.set(user.uid, name, image, []);
    await userRepository.create(data);
    notifyListeners();
  }

  Future<void> read() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userModel = await userRepository.read(user.uid);
    data.fromModel(userModel);
    notifyListeners();
  }

  Future<void> update(String name, String image) async {
    final user = FirebaseAuth.instance.currentUser!;
    data.set(user.uid, name, image, data.team);
    await userRepository.update(user.uid, data);
    notifyListeners();
  }

  Future<void> delete() async {
    final user = FirebaseAuth.instance.currentUser!;
    await userRepository.delete(user.uid);
    await user.delete();
  }

  Future<void> createTeam(String teamId, String teamName) async {
    await teamRepository.create(UserTeam(teamId, teamName));
    data.team.add(UserTeam(teamId, teamName));
    notifyListeners();
  }

  Future<void> readTeam() async {
    final user = FirebaseAuth.instance.currentUser!;
    final List<UserTeam> teams = await teamRepository.read(user.uid);
    data.team = teams;
    notifyListeners();
  }

  Future<void> updateTeam(String teamId, String teamName) async {
    for (var team in data.team) {
      if (team.id == teamId) {
        team = UserTeam(teamId, teamName);
        await teamRepository.update(teamId, team);
      }
    }
    notifyListeners();
  }

  Future<void> delTeam(String teamId) async {
    await teamRepository.delete(teamId);
    data.team.removeWhere((UserTeam userTeam) => userTeam.id == teamId);
    if (data.team.isEmpty) {
      FirebaseFirestore.instance.collection('Team').doc(teamId).delete();
    }
    notifyListeners();
  }
}

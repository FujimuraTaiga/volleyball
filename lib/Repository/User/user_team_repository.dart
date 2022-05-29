import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_volleyball_app/Repository/repository.dart';
import 'package:sit_volleyball_app/Repository/User/user_team.dart';

class UserTeamRepository extends Repository {
  @override
  CollectionReference ref =
      FirebaseFirestore.instance.collection('User').doc().collection('Team');

  @override
  Future<void> create(Model model) async {
    await ref.doc(model.id).set(model.toMap());
    await ref.add(model.toMap());
  }

  @override
  Future<List<UserTeam>> read(String id) async {
    final List<UserTeam> userTeam = [];
    await ref.doc(id).get().then((value) {
      userTeam.add(UserTeam(value.get('id'), value.get('name')));
    });
    return userTeam;
  }

  @override
  Future<void> update(String id, Model model) async {
    final map = model.toMap();
    await ref.doc(id).update(map);
  }

  @override
  Future<void> delete(String id) async {
    await ref.doc(id).delete();
  }
}

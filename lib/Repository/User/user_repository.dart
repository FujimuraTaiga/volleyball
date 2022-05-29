import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_volleyball_app/Repository/repository.dart';
import 'package:sit_volleyball_app/Repository/User/user.dart';
import 'package:sit_volleyball_app/Repository/User/user_team.dart';

class UserRepository extends Repository {
  @override
  CollectionReference ref = FirebaseFirestore.instance.collection('User');

  @override
  Future<void> create(Model model) async {
    await ref.add(model.toMap());
  }

  @override
  Future<UserModel> read(String id) async {
    List<UserTeam> team = [];
    UserModel user = UserModel(id, '', '', []);

    await ref.doc(id).collection('Team').get().then((value) {
      for (var doc in value.docs) {
        team.add(UserTeam(doc.get('id'), doc.get(('name'))));
      }
    });

    await ref.doc(id).get().then((value) {
      user.set(id, value.get('name'), value.get('image'), team);
    });

    return user;
  }

  @override
  Future<void> update(String id, Model model) async {
    final map = model.toMap();
    await ref.doc(id).update(map);
  }

  @override
  Future<void> delete(String id) async {
    await ref.doc(id).collection('Team').doc().delete();
    await ref.doc(id).delete();
  }
}

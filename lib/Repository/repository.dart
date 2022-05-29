import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Model {
  abstract String id;
  abstract String name;
  Map<String, String> toMap();
}

abstract class Repository {
  abstract CollectionReference ref;
  Future<void> create(Model model) async {}
  Future<dynamic> read(String id);
  Future<void> update(String id, Model model) async {}
  Future<void> delete(String id) async {}
}

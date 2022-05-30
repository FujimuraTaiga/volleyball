import 'package:sit_volleyball_app/Repository/repository.dart';

class UserTeam extends Model {
  @override
  late String id;
  @override
  late String name;

  UserTeam(this.id, this.name);

  void fromMap(Map snapshot) {
    id = snapshot['id'] ?? '';
    name = snapshot['name'] ?? '';
  }

  @override
  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

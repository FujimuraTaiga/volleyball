import 'package:sit_volleyball_app/Repository/repository.dart';
import 'package:sit_volleyball_app/Repository/User/user_team.dart';

class UserModel extends Model {
  @override
  late String id;
  @override
  late String name;
  late String image;
  late List<UserTeam> team;

  UserModel(this.id, this.name, this.image, this.team);

  void set(String id, String name, String image, List<UserTeam> team) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.team = team;
  }

  void fromModel(UserModel userModel) {
    id = userModel.id;
    name = userModel.name;
    image = userModel.image;
    team = userModel.team;
  }

  void fromMap(Map map) {
    id = map['id'] ?? '';
    name = map['name'] ?? '';
    image = map['image'] ?? '';
  }

  @override
  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

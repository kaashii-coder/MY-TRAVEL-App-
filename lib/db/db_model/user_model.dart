import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class Usermodel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String password;
  @HiveField(2)
  String email;
  @HiveField(3)
  String age;
  @HiveField(4)
  String? pic;

  Usermodel(
      {required this.name,
      required this.password,
      required this.email,
      required this.age,
      this.pic});
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travelapp/db/db_model/user_model.dart';

ValueNotifier<List<Usermodel>> usernotifier = ValueNotifier([]);

class Userdb extends ChangeNotifier {
  Future<void> adduser(Usermodel user) async {
    final box = await Hive.openBox<Usermodel>('userdbbox');
    await box.add(user);
    await box.close();
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/model/login.dart';

class StorageController extends GetxController {
  GetStorage _shared = GetStorage();

  bool readFirstShowing() {
    return _shared.read("isFirstShowing") ?? true;
  }

  void saveFirstShowing() async {
    _shared.write("isFirstShowing", false);
  }

  bool readLogin() {
    var result = _shared.read("login");
    if (result != null) {
      Login.fromJson(result);
      return true;
    }
    return false;
  }

  void saveLogin(dynamic json) async {
    await _shared.write("login", json);
    await _shared.save();
  }
}
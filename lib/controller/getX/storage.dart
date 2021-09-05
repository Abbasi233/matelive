import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  GetStorage _shared = GetStorage();

  Future<bool> readFirstShowing() async {
    return _shared.read("isFirstShowing") ?? true;
  }

  void saveFirstShowing() async {
    _shared.write("isFirstShowing", false);
  }

  Future<bool> readLoggedIn() async {
    return _shared.read("isLoggedIn") ?? false;
  }

  void saveLoggedIn() async {
    _shared.write("isLoggedIn", true);
  }
}

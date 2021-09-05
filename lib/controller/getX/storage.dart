import 'package:get_storage/get_storage.dart';

class StorageController {
  GetStorage _shared = GetStorage();

  Future<bool> isFirstShowing() async {
    return _shared.read("isFirstShowing") ?? true;
  }

  void saveShowing() async {
    _shared.write("isFirstShowing", false);
  }
}

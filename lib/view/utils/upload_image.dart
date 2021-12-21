import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '/view/utils/snackbar.dart';

dynamic selectImage({String klasorAdi, resimId}) async {
  //https://www.youtube.com/watch?v=pvRpzyBYBbA ios ayarı mevcut.
  int _resimBoyutu = 0;
  int boyutSiniri = 2621440; // 2.5MB
  final _picker = ImagePicker();
  XFile image;

  //yetki kontrolü
  await Permission.photos.request();
  var permissionStatus = await Permission.photos.status;

  if (permissionStatus.isGranted) {
    //resim seçimi
    image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
      imageQuality: 25,
    );

    if (image != null) {
      var file = File(image.path);

      print(file.lengthSync());
      print(
          "${await file.length()} + --------------------------------------------------------------------------");
      _resimBoyutu = await file.length();

      if (_resimBoyutu > boyutSiniri) {
        failureSnackbar(
            "Lütfen 2.5 MB boyutundan daha düşük boyutlu bir resim seçin.");
        return null;
      } else {
        return image;
      }
    }
  } else {
    if (Platform.isIOS) {
      await openAppSettings();
    }
  }
}

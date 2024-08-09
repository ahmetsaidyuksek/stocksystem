import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModel extends ChangeNotifier {
  File? _file;
  File? get file => _file;

  set setFile(File? file) {
    _file = file;
    notifyListeners();
  }

  void pickImage() {
    ImagePicker imagePicker = ImagePicker();

    imagePicker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        _file = File(xFile.path);
        notifyListeners();
      }
    });
  }
}

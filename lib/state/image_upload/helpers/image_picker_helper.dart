import 'dart:io' show File;

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:prototype3/state/image_upload/extensions/to_file.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.camera).toFile();

  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.camera).toFile();
}

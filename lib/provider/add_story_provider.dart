import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storys_apps/data/api/api.dart';
import 'package:storys_apps/data/model/add_story_response.dart';
import 'package:image/image.dart' as img;

class AddStoryProvider extends ChangeNotifier {
  final Api api;

  AddStoryProvider({required this.api});

  bool isUploading = false;
  String message = "";
  AddStoryResponse? addStoryResponse;

  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> addStories(
    List<int> bytes,
    String fileName,
    String description, {
    double lat = 0.0,
    double lon = 0.0,
  }) async {
    try {
      message = "";
      addStoryResponse = null;
      isUploading = true;
      notifyListeners();

      addStoryResponse = await api.addStory(bytes, fileName, description, lat, lon);
      message = addStoryResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<Uint8List> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    Uint8List newByte;

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}

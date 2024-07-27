import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart' as filepicker;
import 'package:fluttertoast/fluttertoast.dart';

final AudioPlayer _audioPlayer = AudioPlayer();
late String _localFilePath;

Future<void> _requestPermissions() async {
  PermissionStatus status = await Permission.storage.request();
  if (!status.isGranted) {
    print('Storage permission not granted');
  }
}

Future<dynamic> pickAndPlayAudio() async {
  await _requestPermissions();
  filepicker.FilePickerResult? result = await filepicker.FilePicker.platform.pickFiles(allowMultiple: true);
  if (result != null) {
    List<String?> files = result.paths??[];
    //print("---------------------------------------------");
    // print(files.toString());
    // print("---------------------------------------------");
    return files;
  } else {
    return [];
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

extension FileX on File {
  String get name {
    if (this == null) return '';

    return path.basename(this?.path ?? '');
  }

  Future<MultipartFile> toMultipartFile() async {
    return MultipartFile.fromFile(this.path, filename: this.name);
  }
}

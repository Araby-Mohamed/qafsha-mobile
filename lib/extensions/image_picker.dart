import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
const double maxWidth = 1000;
const double maxHeight = 1000;
const int imageQuality = 85;

Future<File> getImageFromCamera({bool withCrop = true}) async {
  final XFile pickedFile = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: imageQuality,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );
  if (pickedFile == null || pickedFile.path == null) {
    return null;
  }
  if (!withCrop) {
    return File(pickedFile.path);
  }
  final  _imageCroped = await _cropImage(pickedFile.path);

  return File(_imageCroped.path);
}

Future<File> getImageFromGallery({bool withCrop = true}) async {
  final XFile pickedFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: imageQuality,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );
  if (pickedFile == null || pickedFile.path == null) {
    return null;
  }

  if (!withCrop) {
    return File(pickedFile.path);
  }
  final  _imageCroped = await _cropImage(pickedFile.path);

  return File(_imageCroped.path);
}

Future<File> showImagePicker(BuildContext context,
    {bool withCrop = true}) async {
  return await showModalBottomSheet<File>(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text('gallery'),
                  onTap: () async {
                    final File file = await getImageFromGallery(withCrop: false);
                    Navigator.of(context).pop(file);
                  }),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text('camera'),
                onTap: () async {
                  final File file = await getImageFromCamera(withCrop: false);
                  Navigator.of(context).pop(file);
                },
              ),
            ],
          ),
        );
      });
}

Future<CroppedFile> _cropImage(String imagePath) async {
  final CroppedFile imageCropped = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: <CropAspectRatioPreset>[
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'تعديل الصوره',
            toolbarColor: const Color(0xFF5808D8),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'تعديل الصوره', aspectRatioLockEnabled: false),
      ]);
  return imageCropped;
}

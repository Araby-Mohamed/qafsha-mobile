import 'dart:io';
import 'package:afsha/extensions/context.dart';
import 'package:afsha/extensions/image_picker.dart';
import 'package:afsha/extensions/string.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/material.dart';

class UserPicture extends StatefulWidget {
  const UserPicture({
    Key key,
    this.onSaved,
    this.onChanged,
    this.imagePath,
    this.width,
    this.height,
    this.imageUrl,
    this.required = true,
    this.openPicker = true,
  }) : super(key: key);

  final String imagePath;
  final String imageUrl;
  final bool required;
  final ValueChanged<File> onSaved;
  final ValueChanged<File> onChanged;
  final double width;
  final double height;
  final bool openPicker;

  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<File> pickImageNotifier = ValueNotifier<File>(null);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? context.width * 0.3;
    super.build(context);
    return FormField<File>(
      initialValue: File(widget?.imagePath ?? ''),
      onSaved: (File newValue) {
        if (widget.onSaved != null) widget.onSaved(newValue);
      },
      validator: (File val) {
        if (widget.required && val?.path?.toString()?.isEmptyOrNull()) {
          return 'please_select_picture';
        }
        return null;
      },
      builder: (field) {
        return ValueListenableBuilder<File>(
          valueListenable: pickImageNotifier,
          builder: (context, value, child) {
            String _imagePath = widget.imagePath;
            if (value?.path != null) _imagePath = value?.path;

            return InkWell(
              onTap: () async {
                if (widget.openPicker) {
                  final File file = await showImagePicker(context);
                  if (file?.path != null) {
                    pickImageNotifier.value = file;
                    field.didChange(file);
                    field.validate();
                    if (widget.onChanged != null) widget.onChanged(file);
                  }
                  return;
                }
                // if (widget.imageUrl.isEmptyOrNull ) {
                //   Navigator.pushNamed(context, PageRouteName.DISPLAY_FULL_IMAGES,
                //       arguments: <String, dynamic>{'images': <String>[widget.imageUrl]}
                //       );
             //   }
              },
              child: Container(
                key: ValueKey<bool>(field.hasError),
                width: width,
                height: widget.height ?? context.width * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4FB),
                  border: Border.all(
                    color: field.hasError
                        ? Colors.red.shade800
                        : const Color(0xFFF1F4FB),
                    width: width / 16,
                  ),
                  shape: BoxShape.circle,
                ),
                child: _imagePath != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(120.0),
                  child: Image.file(
                    File(_imagePath),
                    fit: BoxFit.cover,
                  ),
                )
                    : widget.imageUrl.isEmptyOrNull()
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(120.0),
                  child: cachedNetworkImageXCir(
                    imageUrl: widget.imageUrl,

                  ),
                )
                    : Icon(
                  Icons.camera_alt,
                  color: const Color(0xFFA0A0B4),
                  size: context.width * 0.1,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

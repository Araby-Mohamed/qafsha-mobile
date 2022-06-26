import 'package:afsha/Components/Style.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool obscureText;
  final GestureTapCallback onTap;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Color backGroundColor;
  final Color borderColor;
  final bool enabled, readOnly;
  final String hintText;
  final int maxLines;
  final double  height;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  ValueChanged<String> onFieldSubmitted;
  CustomTextField(
      { this.textInputType,
         this.controller,
        this.suffixIcon,
        this.onFieldSubmitted,
        this.obscureText = false,
        this.readOnly = false,
        this.onChanged,
        this.enabled,
        this.backGroundColor,
        this.borderColor,
        this.validator, this.hintText, this.prefixIcon, this.onTap, this.maxLines, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 43,
        child: TextFormField(
          maxLines: maxLines ?? 1,
          onTap: onTap,
            readOnly: readOnly,
            onFieldSubmitted: onFieldSubmitted,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.bottom,
             onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            controller: controller,
            enabled: enabled,
            keyboardType: textInputType,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10, right: 10),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: AppStyle.textStyle12.copyWith(color: AppColors.grayDarkColor),
              fillColor: Colors.white,
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.mainColor.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.mainColor.withOpacity(0.2),),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.mainColor.withOpacity(0.2)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.mainColor.withOpacity(0.2)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.errorColor),
              ),
            )),
      ),
    );
  }
}

import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';

import '../Style.dart';

class EduButton extends StatefulWidget {
  final double width, height;
  final String title;
  final VoidCallback onPressed;
  final TextStyle style;
  final double cornerRadius;
  final MaterialStateProperty<Color> bgColor, borderColor;

  EduButton(
      {this.title,
      this.onPressed,
      this.style,
      this.bgColor,
      this.borderColor,
      this.cornerRadius,
      this.width, this.height});

  @override
  _EduButtonState createState() => _EduButtonState();
}

class _EduButtonState extends State<EduButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.height ?? 45,
      width: widget.width,
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
              backgroundColor:widget.bgColor??  MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30,color: AppColors.mainColor))),
          onPressed: widget.onPressed,
          child: Text(
            widget.title ?? '',
            style: widget.style ??
                TextStyle(
                  color: Color(0xff354052),
                  fontSize: 21,
                ),
            textScaleFactor: 1,
          )),
    );
  }
}

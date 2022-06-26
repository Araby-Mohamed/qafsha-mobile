import 'dart:io';
import 'package:afsha/Components/Style.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';

class ConfirmDialogTwoButton extends StatefulWidget {
  const ConfirmDialogTwoButton(
      {Key key,
      this.onPress,
      this.onPressLift,
      this.bgColor,
      this.mess,
      this.title,
      this.leftButtonText,
      this.rightButtonText,
      this.onAgreeTap,
      this.colorRight})
      : super(key: key);

  final String mess, leftButtonText, rightButtonText, title;
  final Function onAgreeTap;
  final Color bgColor, colorRight;
  final VoidCallback onPress, onPressLift;
  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ConfirmDialogTwoButton> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key key,
     this.widget,
  }) : super(key: key);

  final ConfirmDialogTwoButton widget;

  @override
  Widget build(BuildContext context) {
    const Widget _spacingWidget = SizedBox(
      width: 4,
    );
    const Widget _largeSpacingWidget = SizedBox(
      height: 20,
    );
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _spacingWidget,
        Text(
          widget.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        _spacingWidget,
        Icon(
          Icons.help_outline,
          color: Colors.white,
        ),
      ],
    );

    final Widget _messageWidget = Text(
      widget.mess,
      style: Theme.of(context).textTheme.subtitle2,
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)), color: widget.bgColor ?? AppColors.errorColor,),
              child: _headerWidget),
          _largeSpacingWidget,
          Container(
            height: 70,
            child: Center(child: _messageWidget),
          ),
          _largeSpacingWidget,
          Divider(
            color: AppColors.mainColor.withOpacity(0.3),
            height: 1,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: widget.onPressLift ??
                          () => Navigator.of(context).pop(),
                      child: Text(widget.leftButtonText,
                          style: AppStyle.textStyle15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                      color: widget.colorRight,
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: widget.onPress ?? () => Navigator.of(context).pop(),
                      child: Text(widget.rightButtonText,
                          style: AppStyle.textStyle15),
                    ),
                  ),
                ),
              ])
        ],
      ),
    );
  }
}

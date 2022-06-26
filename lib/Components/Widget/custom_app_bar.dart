import 'package:afsha/Components/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:afsha/extensions/extension.dart';

import 'custom_back_button.dart';

class TitledAppBar {
  final String title;
  final double height;
  final bool withBackButton;
  final GestureTapCallback onTap;
  final Widget leadingWidget;
  final Object heroTag;
  TitledAppBar(
      {this.title,
      this.height,
      this.onTap,
      this.leadingWidget,
      this.heroTag,
      this.withBackButton });

  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
          preferredSize: Size.fromHeight(72),
          child: AppBar(
            title: Text(title, style: AppStyle.textStyle15),
            centerTitle: false,
            elevation: 0,
            brightness: Brightness.light,
            backwardsCompatibility: false,
          )),
    ).addPaddingHorizontalVertical(horizontal: 16);
  }
}

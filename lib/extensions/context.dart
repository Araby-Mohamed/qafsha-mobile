
import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get topSafeArea => MediaQuery.of(this).padding.top;

  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;

  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  double get safeAreaHeight => MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;
}

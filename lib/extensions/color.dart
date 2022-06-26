import 'package:flutter/material.dart';

extension ColorX<T> on T {
  MaterialStateProperty<T> toMaterialStateProperty() {
    return MaterialStateProperty.all<T>(this);
  }
}

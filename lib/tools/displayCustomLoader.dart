import 'package:flutter/material.dart';

import 'customLoader.dart';

displayCustomCircular(BuildContext context) {
  Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new CustomCircularLoad();
      }));
}

closeCustomCircular(BuildContext context) {
  Navigator.of(context).pop();
}

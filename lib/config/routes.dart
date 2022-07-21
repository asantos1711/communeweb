import 'package:flutter/material.dart';

import '../Page404.dart';
import '../vistaQr.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name?.contains("/commune/qr/") ?? false) {
      String codigo = settings.name!.split("/").last;

      return pageRoute(
          "/commune/qr/" + codigo,
          VistaUrl(
            qrCode: codigo,
          ));
    }

    switch (settings.name) {
      case "/login":
        return pageRoute("/inicio", Page404());
      case "/menuConfiguracion":
        return pageRoute("/menuConfiguracion", Page404());

      default:
        return pageRoute("/404", Page404());
    }
  }

  static PageRouteBuilder pageRoute(String name, Widget widget) {
    return PageRouteBuilder(
        settings: RouteSettings(name: name),
        pageBuilder: (_, __, ___) => widget,
        transitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (_, animation, __, ___) => FadeTransition(
              opacity: animation,
              child: widget,
            ));
  }
}

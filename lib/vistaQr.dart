import 'package:communeweb/modelos/invitadoModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'conecciones/conecciones.dart';

class VistaUrl extends StatefulWidget {
  String qrCode;
  VistaUrl({required this.qrCode});

  @override
  State<VistaUrl> createState() => _VistaUrlState();
}

class _VistaUrlState extends State<VistaUrl> {
  late double h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: _carga(),
      ),
    );
  }

  _carga() {
    Conecciones conecciones = Conecciones();
    return FutureBuilder(
      future: conecciones.getProfile(this.widget.qrCode),
      builder: (c, AsyncSnapshot<Invitado?> s) {
        if (s.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (s.data == null || !s.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("¡UPS! No existe el Qr")],
          );
        }

        Invitado invitado = s.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            QrImage(
              data: this.widget.qrCode.toString(),
              version: QrVersions.auto,
              size: 200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "¡Hola! ${invitado.nombre}, este es tu código QR de acceso.",
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    );
  }
}

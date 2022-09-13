import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communeweb/modelos/invitadoModel.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'conecciones/conecciones.dart';
import 'modelos/fraccionamientos.dart';

class VistaUrl extends StatefulWidget {
  String qrCode;
  VistaUrl({required this.qrCode});

  @override
  State<VistaUrl> createState() => _VistaUrlState();
}

class _VistaUrlState extends State<VistaUrl> {
  late double h, w;
  late String _token;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
    setState(() {
      _token = token;
    });
  }

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
            _logo(invitado),
            SizedBox(
              height: 50,
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

  _logo(Invitado invitado) {
    return FutureBuilder(
      future: getFraccionamientoId(invitado.idFraccionamiento!),
      builder: (e, AsyncSnapshot<Fraccionamiento?> s) {
        if (s.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        String url = s.data!.urlLogopng.toString();
        return Container(
          height: 150,
          child: Image.network(url),
        );
      },
    );
  }

  Future<Fraccionamiento?> getFraccionamientoId(String id) async {
    //var snap = _databaseServices.getFracionamientosById(usuario.idFraccionamiento);

    Fraccionamiento _fracc = new Fraccionamiento();

    if (id == "") {
      print("Double tap");
      return null;
    }

    DocumentSnapshot snaps =
        await db.collection('fraccionamientos').doc(id).get();
    print(snaps.data());

    if (snaps.exists) {
      print("dentro");
      Map<String, dynamic> mapa = snaps.data() as Map<String, dynamic>;
      _fracc = Fraccionamiento.fromJson(mapa);
      return _fracc;
    }

    //print(usuarioBloc.miFraccionamiento.color?.r);
  }
}

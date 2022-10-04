import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communeweb/modelos/invitadoModel.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Color _colorFrac = Colors.white;

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
      backgroundColor: Colors.white,
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
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "¡Hola! ${invitado.nombre}, este es tu código QR de acceso.\n Recuerda respetar el reglamento.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _reglamento(),
            SizedBox(
              height: 30,
            ),
            QrImage(
              data: this.widget.qrCode.toString(),
              version: QrVersions.auto,
              size: 200,
            ),
            
            
            
            _logo(invitado),
          ],
        );
      },
    );
  }

  _launchURLBrowser(String url) async {
    //const url = 'https://www.google.com/maps/dir//21.1109375,-86.8425279/@21.1108518,-86.9125808,12z';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _logo(Invitado invitado) {
    return FutureBuilder(
      future: getFraccionamientoId(invitado.idFraccionamiento!),
      builder: (e, AsyncSnapshot<Fraccionamiento?> s) {
        if (s.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        String url = s.data!.urlLogopng.toString();     
        _colorFrac = s.data!.getColor();   
        String urlUbicacion = s.data!.urlUbicacion.toString();

        return Column(children: [
          Container(
              child: Text("¿No sabes cómo llegar? "),
            ),
          InkWell(
              onTap: (){
                _launchURLBrowser(urlUbicacion);
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: _colorFrac,
                  border: Border.all(
                    width: 1.0,
                    color: _colorFrac
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(25.0) //                 <--- border radius here
                  ),
                ),
                child: Text("Ver ubicación", style: TextStyle(color: Colors.white),)
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
            height: 150,
            child: Image.network(url),
          ),
        ],);
        
        
      },
    );
  }


   _reglamento(){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 10),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(25.0) //                 <--- border radius here
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          child: Text("1.- LÍMITE DE VELOCIDAD 30 KM/H BOULEVARD CUMBRES"),
        ),
        Container(
          child: Text("2.- LÍMITE DE VELOCIDAD 20 KM/H EN CALLES INTERNAS"),
        ),
        Container(
          child: Text("3.- SANCIÓN DE \$ 750. 00 PESOS M.N. POR EXCESO DE VELOCIDAD"),
        ),
        Container(
          child: Text("4.- PROHIBIDO TEXTEAR MIENTRAS CONDUCES"),
        ),
        Container(
          child: Text("5.- ES NECESARIO PRESENTAR UNA IDENTIFICACIÓN OFICIAL AL INGRESAR"),
        ),
        Container(
          child: Text("6.- NO ESTACIONARSE EN PROPIEDADES PRIVADAS"),
        ),
      ]),
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

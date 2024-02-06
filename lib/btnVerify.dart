import 'package:communeweb/modelos/trustswiftly/responseGet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MagicLink.dart';
import 'conecciones/conecciones.dart';
import 'conecciones/trustswiftly.dart';
import 'modelos/invitadoModel.dart';
import 'modelos/trustswiftly/responseCreate.dart';

class BotonVerificacion extends StatefulWidget {
  Invitado invitado;
  BotonVerificacion({required this.invitado});

  @override
  State<BotonVerificacion> createState() => _BotonVerificacionState();
}

class _BotonVerificacionState extends State<BotonVerificacion> {
  late Invitado invitado;
  @override
  void initState() {
    // TODO: implement initState
    invitado = this.widget.invitado;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("invitado.status_veri");
    print(invitado.status_veri);
    if (invitado.status_veri == false || invitado.status_veri == null) {
      return verificacionUsuario();
    } else {
      return verificado();
    }
  }

  Widget verificado() {
    return Icon(
      Icons.verified,
      color: Colors.green,
    );
  }

  verificacionUsuario() {
    return FutureBuilder(
      future: getUsuario(invitado),
      builder: (e, AsyncSnapshot<ResponseGet> dt) {
        if (dt.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!dt.hasData) {
          return SizedBox();
        }

        if (dt.data?.data?.id == null) {
          return SizedBox();
        }

        if (dt.data!.data!.verifications![0].status?.value != null &&
            dt.data!.data!.verifications![0].status!.value != 2 &&
            !invitado.status_veri!) {
          return MagicLink(invitado.magicLink.toString());
        }

        if (invitado.status_veri!) {
          return Icon(
            Icons.verified,
            color: Colors.green,
          );
        }
        if (dt.data!.data!.verifications![0].status!.value == 2 &&
            !invitado.status_veri!) {
          Conecciones con = Conecciones();
          con.setStatusInvitado(invitado.id!);
          return Icon(
            Icons.verified,
            color: Colors.green,
          );
        }
        return SizedBox();
      },
    );
  }

  Future<ResponseGet> getUsuario(Invitado invitado) async {
    Trustswiftly instance = Trustswiftly();
    ResponseGet response = await instance.getUser(invitado.id_veri.toString());
    return response;
  }
}

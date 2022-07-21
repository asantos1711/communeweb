import 'package:flutter/material.dart';

class VistaUrl extends StatefulWidget {
  String qrCode;
  VistaUrl({required this.qrCode});

  @override
  State<VistaUrl> createState() => _VistaUrlState();
}

class _VistaUrlState extends State<VistaUrl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Aqui va qr " + this.widget.qrCode),
    );
  }
}

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';


class ReceiveWithQRCode extends StatefulWidget {
  const ReceiveWithQRCode({Key? key}) : super(key: key);

  @override
  _ReceiveWithQRCodeState createState() => _ReceiveWithQRCodeState();
}

class _ReceiveWithQRCodeState extends State<ReceiveWithQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Receive With QR Code"),
      ),
    );
  }
}

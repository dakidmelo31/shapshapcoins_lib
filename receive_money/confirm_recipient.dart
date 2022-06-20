// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';



class ConfirmRecipient extends StatefulWidget {
  static const routeName = "/sendMoney/confirmRecipient";
  const ConfirmRecipient({Key? key}) : super(key: key);

  @override
  _ConfirmRecipientState createState() => _ConfirmRecipientState();
}

class _ConfirmRecipientState extends State<ConfirmRecipient> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Confirming Recipient"),
    );
  }
}

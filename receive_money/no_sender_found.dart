// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class NoSenderFound extends StatelessWidget {
  static const routeName = "/receiveMoney/senderNumber/noSenderFound";
  const NoSenderFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("No Sender Found Screen"),
      ),
    );
  }
}

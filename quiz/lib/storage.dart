import 'package:flutter/material.dart';

class Storage extends StatelessWidget {
  final String code;

  Storage(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          code,
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ));
  }
}

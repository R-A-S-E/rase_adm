import 'package:flutter/material.dart';

class VenderPage extends StatefulWidget {
  @override
  _VenderPageState createState() => _VenderPageState();
}

class _VenderPageState extends State<VenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
      "Vender",
      style: TextStyle(color: Colors.white70),
    )));
  }
}

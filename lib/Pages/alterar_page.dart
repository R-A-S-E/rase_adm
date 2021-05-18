import 'package:flutter/material.dart';

class AlterarPage extends StatefulWidget {
  @override
  _AlterarPageState createState() => _AlterarPageState();
}

class _AlterarPageState extends State<AlterarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
      "Alterar",
      style: TextStyle(color: Colors.white70),
    )));
  }
}

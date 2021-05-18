import 'package:flutter/material.dart';

class CadastrarPage extends StatefulWidget {
  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
      "Cadastrar",
      style: TextStyle(color: Colors.white70),
    )));
  }
}

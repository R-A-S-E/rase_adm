import 'package:flutter/material.dart';

class RelatorioPage extends StatefulWidget {
  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
      "Relatórios",
      style: TextStyle(color: Colors.white70),
    )));
  }
}

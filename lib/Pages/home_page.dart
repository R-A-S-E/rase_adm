import 'package:flutter/material.dart';
import 'package:rase_adm/Pages/alterar_page.dart';
import 'package:rase_adm/Pages/cadastrar_page.dart';
import 'package:rase_adm/Pages/relatorio_page.dart';
import 'package:rase_adm/Pages/vender_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Início",
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ColoredBox(
                color: Colors.grey[850],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    textBut("Cadastrar", CadastrarPage()),
                    textBut("Alterar", AlterarPage()),
                    textBut("Vender", VenderPage()),
                    textBut("Relatórios", RelatorioPage()),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget textBut(String text, Widget local) {
    return Container(
        child: TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => local));
      },
      child: Text(text, style: TextStyle(color: Colors.white70)),
    ));
  }
}
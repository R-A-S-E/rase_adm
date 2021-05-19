import 'package:flutter/material.dart';
import 'package:rase_adm/Controller/cadastrar_controller.dart';

class CadastrarPage extends StatefulWidget {
  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cadastrar",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            formProdut(
                "Nome do produto", TextInputType.text, "", produtoController),
            formProdut(
                "Quantidade", TextInputType.number, "", quantidadeController),
            formProdut(
                "Valor real", TextInputType.number, "R\$ ", valorController),
            formProdut(
                "Valor venda", TextInputType.number, "R\$ ", vendaController),
            Padding(
              padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  cadas();
                  Navigator.pop(context);
                },
                child: Text("Cadastrar", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, minimumSize: Size(340.0, 60.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formProdut(
      String text, TextInputType type, String prefix, TextEditingController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: TextFormField(
        keyboardType: type,
        controller: c,
        decoration: InputDecoration(
            prefixText: prefix,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700], width: 3.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[900], width: 3.0),
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.white70)),
        style: TextStyle(color: Colors.white70, fontSize: 18.0),
      ),
    );
  }
}

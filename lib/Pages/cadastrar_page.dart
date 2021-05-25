import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rase_adm/model/produtos.dart';

class CadastrarPage extends StatefulWidget {
  final Produto prod;
  CadastrarPage(this.prod);

  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final db = FirebaseFirestore.instance;

  TextEditingController _produtoController;
  TextEditingController _quantidadeController;
  TextEditingController _valorController;
  TextEditingController _vendaController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _produtoController = new TextEditingController(text: widget.prod.nome);
    _quantidadeController =
        new TextEditingController(text: widget.prod.quantidade);
    _valorController = new TextEditingController(text: widget.prod.preco);
    _vendaController = new TextEditingController(text: widget.prod.venda);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (widget.prod.id != null)
            ? Text("Editar",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold))
            : Text("Cadastrar",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            formProdut(
                "Nome do produto", TextInputType.name, "", _produtoController),
            formProdut(
                "Quantidade", TextInputType.number, "", _quantidadeController),
            formProdut(
                "Valor real", TextInputType.number, "R\$ ", _valorController),
            formProdut(
                "Valor venda", TextInputType.number, "R\$ ", _vendaController),
            Padding(
              padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    db.collection('produtos').doc(widget.prod.id).set({
                      "nome": _produtoController.text,
                      "quantidade": _quantidadeController.text,
                      "valor": _valorController.text,
                      "venda": _vendaController.text,
                    });

                    Navigator.pop(context);
                  }
                },
                child: (widget.prod.id != null)
                    ? Text("Atualizar", style: TextStyle(fontSize: 20))
                    : Text("Cadastrar", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, minimumSize: Size(340.0, 60.0)),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget formProdut(
      String text, TextInputType type, String prefix, TextEditingController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "O campo é obrigatório";
          } else {
            return null;
          }
        },
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

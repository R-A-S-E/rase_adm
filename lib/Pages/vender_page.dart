import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rase_adm/model/carrinho.dart';
import 'package:rase_adm/model/produtos.dart';

class VenderPage extends StatefulWidget {
  @override
  _VenderPageState createState() => _VenderPageState();
}

class _VenderPageState extends State<VenderPage> {
  List<CartProduct> produtos = [];
  List<Produto> itens;
  var db = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> produtoInscricao;
  static String _displayStringForOption(Produto produto) => produto.nome;

  @override
  void initState() {
    super.initState();

    itens = [];
    produtoInscricao?.cancel();

    produtoInscricao = db.collection('produtos').snapshots().listen((snapshot) {
      final List<Produto> produtos = snapshot.docs
          .map((documentSnapshot) =>
              Produto.fromMap(documentSnapshot.data(), documentSnapshot.id))
          .toList();
      setState(() {
        this.itens = produtos;
      });
    });
  }

  @override
  void dispose() {
    produtoInscricao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Vendas",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.white,
        body: Autocomplete<Produto>(
          displayStringForOption: _displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<Produto>.empty();
            }
            return itens.where((Produto produto) {
              return produto.nome.contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (Produto selection) {
            print('${_displayStringForOption(selection)}');
          },
        ));
  }
}

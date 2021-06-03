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
  List<CartProduct> cprodutos = [];
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
        body: Column(
          children: <Widget>[
            Autocomplete<Produto>(
              displayStringForOption: _displayStringForOption,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<Produto>.empty();
                }
                return itens.where((Produto produto) {
                  return produto.nome
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (Produto produto) {
                CartProduct cartProduct = CartProduct();
                cartProduct.id = produto.id;
                cartProduct.quantidade = 1;
                cartProduct.nome = produto.nome;
                cartProduct.venda = produto.venda;
                addCartItem(cartProduct);
              },
            ),
            //DataTable(columns: columns, rows: rows)
            Padding(
              padding: EdgeInsets.all(10),
              child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(64),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      Container(
                        width: 20,
                        child: Text(" ID"),
                      ),
                      Container(
                        width: 64,
                        child: Text("ALuz puto"),
                      ),
                      Container(
                        width: 64,
                        child: Text("Amém a lux"),
                      ),
                      Container(
                        width: 64,
                        child: Text("ALuz puto"),
                      ),
                      Container(
                        width: 64,
                        child: Text("ALuz puto"),
                      ),
                    ])
                  ]),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cprodutos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // _showOptions(context, index, doc);
                  },
                  child: ListTile(
                    title: Text(cprodutos[index].nome),
                    subtitle: Text("${cprodutos[index].quantidade}"),
                  ),
                );
              },
            )),
          ],
        ));
  }

  void addCartItem(CartProduct cartProduct) {
    cprodutos.add(cartProduct);
    setState(() {});
  }

  void removeCartItem(CartProduct cartProduct) {
    db.collection("vendas").doc(cartProduct.id).delete();
    cprodutos.remove(cartProduct);
    setState(() {});
  }
}

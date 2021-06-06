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
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Autocomplete<Produto>(
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
                cartProduct.venda = double.parse(produto.venda);
                addCartItem(cartProduct);
              },
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: DataTable(
              dataRowHeight: 50,
              columnSpacing: 25,
              columns: <DataColumn>[
                DataColumn(label: Text("PROD")),
                DataColumn(label: Text("QTD")),
                DataColumn(label: Text("PREÇO")),
                DataColumn(label: Text("R\$")),
              ],
              rows: cprodutos
                  .map(
                    (prod) => DataRow(cells: [
                      DataCell(Text(prod.nome)),
                      DataCell(Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Icon(Icons.remove_circle),
                          ),
                          Text(
                            '${prod.quantidade}',
                            textAlign: TextAlign.right,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.add_circle),
                          )
                        ],
                      )),
                      DataCell(Text('${prod.venda}')),
                      DataCell(Container(
                        child: Text('${prod.quantidade * prod.venda}'),
                      )),
                    ]),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
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

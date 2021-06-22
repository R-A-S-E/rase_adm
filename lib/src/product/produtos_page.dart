import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rase_adm/Pages/cadastrar_page.dart';
import 'package:rase_adm/shared/model/produtos.dart';
import 'package:rase_adm/shared/widgets/produc_card_widget.dart';

enum OrderOptions { orderaz, orderza }

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  List<Produto> itens;
  var db = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> produtoInscricao;
  bool order = false;

  @override
  void initState() {
    super.initState();

    itens = [];
    produtoInscricao?.cancel();

    produtoInscricao = db
        .collection('produtos')
        .orderBy('nome', descending: order)
        .snapshots()
        .listen((snapshot) {
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
          "Alterar",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            color: Colors.grey,
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Text("Ordenar de A-Z"), value: OrderOptions.orderaz),
              PopupMenuItem(
                  child: Text("Ordenar de Z-A"), value: OrderOptions.orderza),
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: getListProd(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    List<DocumentSnapshot> doc = snapshot.data.docs;
                    return ListView.builder(
                        itemCount: doc.length,
                        itemBuilder: (context, index) => ProductCard(
                              doc: itens,
                              index: index,
                            ));
                }
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
        onPressed: () => _criarNovoProd(context, Produto(null, '', '', '', '')),
      ),
    );
  }

  Stream<QuerySnapshot> getListProd() {
    return FirebaseFirestore.instance
        .collection("produtos")
        .orderBy('nome', descending: order)
        .snapshots();
  }

  void _criarNovoProd(context, Produto prod) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CadastrarPage(Produto(null, '', '', '', ''))));
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        order = false;
        break;
      case OrderOptions.orderza:
        order = true;
        break;
    }
    setState(() {});
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rase_adm/Pages/cadastrar_page.dart';
import 'package:rase_adm/model/produtos.dart';

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
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            color: Colors.grey[900],
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: 170.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color: Colors.grey[850]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                      child: Text(
                                        doc[index]['nome'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                    Container(
                                      width: 170.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[850],
                                        border: Border.all(
                                            width: 2.0,
                                            color: Colors.grey[850]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.sticky_note_2,
                                                size: 32.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text(doc[index]['quantidade'],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.account_balance_wallet,
                                                size: 32.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text("R\$ " + doc[index]['valor'],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.store,
                                                size: 32.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text("R\$ " + doc[index]['venda'],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          onTap: () {
                            _showOptions(context, index, doc);
                          },
                        );
                      },
                    );
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

  void _showOptions(BuildContext context, int index, List doc) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  width: 380.0,
                  color: Colors.grey[850],
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: 380.0,
                        color: Colors.grey[900],
                        padding: EdgeInsets.all(10.0),
                        child: Text(doc[index]['nome'],
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: 380.0,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.black))),
                        child: TextButton(
                            child: Text("Editar",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20.0)),
                            onPressed: () =>
                                _navProduto(context, itens[index])),
                      ),
                      Container(
                        width: 380.0,
                        padding: EdgeInsets.all(10.0),
                        child: TextButton(
                          child: Text("Deletar",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                            _deletProd(context, doc[index], index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Stream<QuerySnapshot> getListProd() {
    return FirebaseFirestore.instance
        .collection("produtos")
        .orderBy('nome', descending: order)
        .snapshots();
  }

  void _deletProd(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection('produtos').doc(doc.id).delete();
    setState(() {
      itens.removeAt(position);
    });
  }

  void _criarNovoProd(context, Produto prod) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CadastrarPage(Produto(null, '', '', '', ''))));
  }

  void _navProduto(context, Produto prod) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CadastrarPage(prod)));
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

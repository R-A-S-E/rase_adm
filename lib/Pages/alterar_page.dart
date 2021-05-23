import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlterarPage extends StatefulWidget {
  @override
  _AlterarPageState createState() => _AlterarPageState();
}

class _AlterarPageState extends State<AlterarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Alterar",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Produtos')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Text("Quantidade" + document['Quantidade']),
                        ),
                      );
                    }).toList(),
                  );
                }),
          )
        ]));
  }
}

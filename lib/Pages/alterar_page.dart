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
        backgroundColor: Colors.black,
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('produtos')
                    .snapshots(),
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
                                        width: 180.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2.0,
                                              color: Colors.grey[850]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        child: Text(
                                          doc[index].id,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.sticky_note_2,
                                                size: 35.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text(doc[index]['quantidade'],
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.account_balance_wallet,
                                                size: 35.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text("R\$ " + doc[index]['valor'],
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.store,
                                                size: 35.0,
                                                color: Colors.grey[700],
                                              ),
                                              Text("R\$ " + doc[index]['venda'],
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white70,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            onTap: () {
                              _showOptions(context, index);
                            },
                          );
                        },
                      );
                  }
                }),
          )
        ]));
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  color: Colors.grey[800],
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextButton(
                          child: Text("Editar",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextButton(
                          child: Text("Excluir",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20.0)),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}

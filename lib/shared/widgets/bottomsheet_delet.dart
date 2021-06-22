import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rase_adm/shared/model/produtos.dart';

class BottomSheetDelet extends StatelessWidget {
  final List<Produto> itens;
  final int index;
  const BottomSheetDelet({Key key, this.itens, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Text("tem certeza ?",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        child: Text("Sim",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 20.0)),
                        onPressed: () {
                          Navigator.pop(context);
                          _deletProd(context, itens[index], index);
                        }),
                    TextButton(
                      child: Text("Não",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _deletProd(BuildContext context, Produto doc, int position) async {
    FirebaseFirestore.instance.collection('produtos').doc(doc.id).delete();
    itens.removeAt(position);
  }
}

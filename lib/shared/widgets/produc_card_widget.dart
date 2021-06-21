import 'package:flutter/material.dart';
import 'package:rase_adm/shared/model/produtos.dart';
import 'package:rase_adm/shared/widgets/BottomSheet_opt1.dart';

class ProductCard extends StatelessWidget {
  final Produto doc;
  const ProductCard({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    border: Border.all(width: 2.0, color: Colors.grey[850]),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Text(
                    doc.nome,
                    style: TextStyle(fontSize: 18.0, color: Colors.white70),
                  ),
                ),
                Container(
                  width: 170.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    border: Border.all(width: 2.0, color: Colors.grey[850]),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.sticky_note_2,
                            size: 32.0,
                            color: Colors.grey[700],
                          ),
                          Text(doc.quantidade,
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
                          Text("R\$ " + doc.preco,
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
                          Text("R\$ " + doc.venda,
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
        print(doc.id);
        BottomShetopt1(doc: doc);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rase_adm/shared/model/produtos.dart';

class BottomShetopt1 extends StatelessWidget {
  final List<Produto> doc;
  final int index;
  const BottomShetopt1({Key key, this.doc, this.index}) : super(key: key);

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
                  child: Text('${doc[index].nome}',
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
                          bottom: BorderSide(width: 1, color: Colors.black))),
                  child: TextButton(
                      child: Text("Editar",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 20.0)),
                      onPressed: () {
                        // _navProduto(context, itens[index]);
                      }),
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
                      // _showOptions2(context, index, doc);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rase_adm/model/produtos.dart';

class CartProduct {
  String id;
  int quantity;
  String pid;

  Produto productData;

  CartProduct.fromDocument(DocumentSnapshot doc) {
    pid = doc.id;
    pid = doc['pid'];
    quantity = doc['quantity'];
  }

  Map<String, dynamic> toMap() {
    return {
      "pid": pid,
      "quantity": quantity,
    };
  }
}

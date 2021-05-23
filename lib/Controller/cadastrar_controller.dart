import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final produtoController = TextEditingController();
final quantidadeController = TextEditingController();
final valorController = TextEditingController();
final vendaController = TextEditingController();

cadas() {
  FirebaseFirestore.instance
      .collection("produtos")
      .doc("${produtoController.text}")
      .set({
    'quantidade': "${quantidadeController.text}",
    'valor': "${valorController.text}",
    'venda': "${vendaController.text}"
  });
  produtoController.text = "";
  quantidadeController.text = "";
  valorController.text = "";
  vendaController.text = "";
}

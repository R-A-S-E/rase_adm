import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final produtoController = TextEditingController();
final quantidadeController = TextEditingController();
final valorController = TextEditingController();
final vendaController = TextEditingController();

cadas() {
  FirebaseFirestore.instance
      .collection("Produtos")
      .doc("${produtoController.text}")
      .set({
    'Quantidade': "${quantidadeController.text}",
    'Valor': "${valorController.text}",
    'Venda': "${vendaController.text}"
  });
  produtoController.text = "";
  quantidadeController.text = "";
  valorController.text = "";
  vendaController.text = "";
}

class CartProduct {
  String id;
  int quantidade;
  String nome;
  double venda;

  CartProduct();

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "quantidade": quantidade,
      "venda": venda,
    };
  }
}

class CartProduct {
  String id;
  int quantidade;
  String nome;
  String venda;

  CartProduct();

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "quantidade": quantidade,
      "venda": venda,
    };
  }
}

class Produto {
  String _id;
  String _nome;
  String _quantidade;
  String _preco;
  String _venda;

  Produto(this._id, this._nome, this._quantidade, this._preco, this._venda);

  Produto.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._quantidade = obj['quantidade'];
    this._preco = obj['valor'];
    this._venda = obj['venda'];
  }

  String get id => _id;
  String get nome => _nome;
  String get quantidade => _quantidade;
  String get preco => _preco;
  String get venda => _venda;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['quantidade'] = _quantidade;
    map['valor'] = _preco;
    map['venda'] = _venda;

    return map;
  }

  Produto.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    this._nome = map['nome'];
    this._quantidade = map['quantidade'];
    this._preco = map['valor'];
    this._venda = map['venda'];
  }
}

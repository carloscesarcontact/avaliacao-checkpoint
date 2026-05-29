import 'produto_model.dart';

class CartItem {
  final Produto produto;
  int quantidade;
  String? corSelecionada;

  CartItem({required this.produto, this.quantidade = 1, this.corSelecionada});

  double get subtotal => produto.preco * quantidade;
}

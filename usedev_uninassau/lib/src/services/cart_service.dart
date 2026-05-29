import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/produto_model.dart';

class CartService extends ChangeNotifier {
  // Singleton
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _itens = [];
  String? _cupomAplicado;
  double _desconto = 0.0;

  List<CartItem> get itens => List.unmodifiable(_itens);
  double get desconto => _desconto;
  String? get cupomAplicado => _cupomAplicado;

  int get totalItens => _itens.fold(0, (sum, item) => sum + item.quantidade);

  double get subtotalPreco =>
      _itens.fold(0.0, (sum, item) => sum + item.subtotal);

  double get totalPreco => subtotalPreco - _desconto;

  bool aplicarCupom(String cupom) {
    if (cupom.toUpperCase() == 'USEDEV10') {
      _cupomAplicado = cupom.toUpperCase();
      _desconto = subtotalPreco * 0.10;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removerCupom() {
    _cupomAplicado = null;
    _desconto = 0.0;
    notifyListeners();
  }

  void adicionarProduto(Produto produto, {String? cor}) {
    final index = _itens.indexWhere((i) => i.produto.id == produto.id);
    if (index >= 0) {
      _itens[index].quantidade++;
    } else {
      _itens.add(CartItem(produto: produto, corSelecionada: cor));
    }
    if (_cupomAplicado != null) {
      _desconto = subtotalPreco * 0.10;
    }
    notifyListeners();
  }

  void removerProduto(int produtoId) {
    _itens.removeWhere((i) => i.produto.id == produtoId);
    if (_cupomAplicado != null) {
      _desconto = subtotalPreco * 0.10;
    }
    notifyListeners();
  }

  void incrementar(int produtoId) {
    final index = _itens.indexWhere((i) => i.produto.id == produtoId);
    if (index >= 0) {
      _itens[index].quantidade++;
      if (_cupomAplicado != null) {
        _desconto = subtotalPreco * 0.10;
      }
      notifyListeners();
    }
  }

  void decrementar(int produtoId) {
    final index = _itens.indexWhere((i) => i.produto.id == produtoId);
    if (index >= 0) {
      if (_itens[index].quantidade > 1) {
        _itens[index].quantidade--;
      } else {
        _itens.removeAt(index);
      }
      if (_cupomAplicado != null) {
        _desconto = subtotalPreco * 0.10;
      }
      notifyListeners();
    }
  }

  void limpar() {
    _itens.clear();
    _cupomAplicado = null;
    _desconto = 0.0;
    notifyListeners();
  }
}

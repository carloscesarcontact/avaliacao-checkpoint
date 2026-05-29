import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/produto_model.dart';
import '../services/cart_service.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/footer_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartService _cartService = CartService();
  String? _corSelecionada;
  int _quantidade = 1;

  void _adicionarAoCarrinho(Produto produto) {
    _cartService.adicionarProduto(produto, cor: _corSelecionada);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${produto.titulo} adicionado ao carrinho!',
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        backgroundColor: const Color(0xFF780BF7),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produto = ModalRoute.of(context)!.settings.arguments as Produto;

    return Scaffold(
      appBar: const CustomAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios, size: 16),
                    Text(
                      'Detalhes do Produto',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Image.network(
                  produto.imagem,
                  height: 250,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.titulo,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.orbitron().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.share_outlined, size: 28),
                      SizedBox(width: 16),
                      Icon(Icons.favorite_border, size: 28, color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    produto.descricao,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'R\$ ${produto.preco.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.orbitron().fontFamily,
                      color: const Color(0xFF780BF7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Escolha a cor do tecido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...['Bege', 'Branca', 'Cinza'].map((cor) {
                    return InkWell(
                      onTap: () => setState(() => _corSelecionada = cor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _corSelecionada == cor
                                      ? const Color(0xFF780BF7)
                                      : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: _corSelecionada == cor
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF780BF7),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cor,
                              style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    initialValue: _quantidade,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: List.generate(10, (i) => i + 1)
                        .map(
                          (q) => DropdownMenuItem(value: q, child: Text('$q')),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _quantidade = value ?? 1);
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Tamanho',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: ['P', 'M', 'G', 'GG']
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF780BF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Adicionar ao carrinho',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      onPressed: () => _adicionarAoCarrinho(produto),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

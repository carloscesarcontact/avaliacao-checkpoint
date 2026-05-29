import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D1A),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo_usedev.png', height: 50),
          const SizedBox(height: 8),
          Text(
            'Hora de abraçar seu lado geek!',
            style: TextStyle(
              color: const Color(0xFF8FFF24),
              fontFamily: GoogleFonts.orbitron().fontFamily,
              fontSize: 12,
            ),
          ),
          const Divider(color: Colors.white24, height: 32),
          _buildSecao('Funcionamento', [
            'Segunda a Sexta - 8h às 18h',
            'sac@usedev.com.br',
            '0800 541 320',
          ]),
          const SizedBox(height: 16),
          _buildSecao('Institucional', [
            'Sobre nós',
            'Contato',
            'Política de Privacidade',
            'LGPD - Lei de proteção de dados',
          ]),
          const SizedBox(height: 16),
          _buildSecao('Informações', [
            'Entregas',
            'Garantia',
            'Trocas e devoluções',
          ]),
          const SizedBox(height: 24),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          Text(
            'Desenvolvido por Alura. Projeto fictício sem fins comerciais.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecao(String titulo, List<String> itens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...itens.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 13,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

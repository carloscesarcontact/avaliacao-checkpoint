import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cart_service.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 30, color: Colors.black),
        onPressed: () {},
      ),
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, size: 30, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, '/login');
            }
          },
        ),
        ListenableBuilder(
          listenable: cartService,
          builder: (context, _) {
            final total = cartService.totalItens;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, '/cart');
                    }
                  },
                ),
                if (total > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFF780BF7),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

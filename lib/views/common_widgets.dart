import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/app_styles.dart';

/// AppBar with the shop logo and optional cart indicator so every screen matches.
class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCartStatus;

  const ShopAppBar({
    super.key,
    required this.title,
    this.showCartStatus = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      title: Text(title, style: heading1),
      actions: showCartStatus
          ? <Widget>[
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.shopping_cart),
                        const SizedBox(width: 4),
                        Text('${cart.countOfItems}'),
                      ],
                    ),
                  );
                },
              ),
            ]
          : null,
    );
  }
}

/// Simple text summary of the cart count and total for reuse across screens.
class CartSummaryText extends StatelessWidget {
  final TextAlign textAlign;

  const CartSummaryText({super.key, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Text(
          'Cart: ${cart.countOfItems} items - £${cart.totalPrice.toStringAsFixed(2)}',
          style: normalText,
          textAlign: textAlign,
        );
      },
    );
  }
}

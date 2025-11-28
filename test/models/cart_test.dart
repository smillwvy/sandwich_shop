import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Cart', () {
    test('adds sandwiches and updates quantity', () {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.white,
      );

      cart.addSandwich(sandwich);

      expect(cart.totalQuantity, 1);
      expect(cart.items.first, sandwich);
    });

    test('removes a sandwich and keeps the others', () {
      final cart = Cart();
      final footlong = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sixInch = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      cart.addSandwich(footlong);
      cart.addSandwich(sixInch);
      cart.removeSandwich(footlong);

      expect(cart.items.contains(footlong), isFalse);
      expect(cart.items.contains(sixInch), isTrue);
      expect(cart.totalQuantity, 1);
    });

    test('clear removes everything', () {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );

      cart.addSandwich(sandwich);
      cart.addSandwich(sandwich);
      cart.clear();

      expect(cart.totalQuantity, 0);
      expect(cart.items, isEmpty);
    });

    test('calculates total price using PricingRepository rates', () {
      final cart = Cart();
      final footlong = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sixInch = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      cart.addSandwich(footlong);
      cart.addSandwich(footlong);
      cart.addSandwich(sixInch);

      expect(cart.totalQuantity, 3);
      expect(cart.totalPrice, 29.00); // 2 footlongs (2*11) + 1 six-inch (7)
    });
  });
}

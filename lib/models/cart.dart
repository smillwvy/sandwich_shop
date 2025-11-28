import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final PricingRepository _pricingRepository;
  final List<Sandwich> _items = [];

  Cart({PricingRepository? pricingRepository})
      : _pricingRepository = pricingRepository ?? PricingRepository();

  List<Sandwich> get items => List.unmodifiable(_items);

  int get totalQuantity => _items.length;

  double get totalPrice {
    int footlongCount = 0;
    int sixInchCount = 0;

    for (Sandwich sandwich in _items) {
      if (sandwich.isFootlong) {
        footlongCount++;
      } else {
        sixInchCount++;
      }
    }

    double footlongTotal = _pricingRepository.calculatePrice(
      quantity: footlongCount,
      isFootlong: true,
    );
    double sixInchTotal = _pricingRepository.calculatePrice(
      quantity: sixInchCount,
      isFootlong: false,
    );

    return footlongTotal + sixInchTotal;
  }

  void add(Sandwich sandwich, {int quantity = 1}) {
    addSandwich(sandwich, quantity: quantity);
  }

  void addSandwich(Sandwich sandwich, {int quantity = 1}) {
    if (quantity < 1) return;
    for (int i = 0; i < quantity; i++) {
      _items.add(sandwich);
    }
  }

  void removeSandwich(Sandwich sandwich) {
    _items.remove(sandwich);
  }

  void clear() {
    _items.clear();
  }
}

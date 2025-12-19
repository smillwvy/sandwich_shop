import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/user.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/app_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStyles.loadFontSize();
  _demoJsonSerialization();
  runApp(const App());
}

void _demoJsonSerialization() {
  final user = User.fromJson(
    const {
      'name': 'John Smith',
      'email': 'john@example.com',
    },
  );
  debugPrint('User: ${user.name}, ${user.email}');

  final json = user.toJson();
  debugPrint('User JSON: $json');
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { 
        return Cart();
      },
      child: const MaterialApp(
        title: 'Sandwich Shop App',
        debugShowCheckedModeBanner: false,
        home: OrderScreen(maxQuantity: 5),
      ),
    );
  }
}

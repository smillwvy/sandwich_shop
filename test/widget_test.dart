import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  testWidgets('App renders OrderScreen as home', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(OrderScreen), findsOneWidget);
    expect(find.text('Sandwich Counter'), findsOneWidget);
  });

  group('OrderScreen - Quantity', () {
    testWidgets('starts at quantity 1 and shows it', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('increments and decrements with icon buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('toggles sandwich size with Switch', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final Switch initialSwitch = tester.widget(find.byType(Switch));
      expect(initialSwitch.value, isTrue); // starts as footlong
      await tester.tap(find.byType(Switch));
      await tester.pump();
      final Switch updatedSwitch = tester.widget(find.byType(Switch));
      expect(updatedSwitch.value, isFalse);
    });

    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      expect(find.text('wheat'), findsWidgets);
    });
  });

  group('Cart summary', () {
    testWidgets('shows initial cart summary as 0 items and £0.00',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Items in cart: 0'), findsOneWidget);
      expect(find.text('Total price: £0.00'), findsOneWidget);
    });

    testWidgets('updates cart summary after adding to cart',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.text('Add to Cart'));
      await tester.pump(); // rebuild after setState; snackbar can animate separately
      expect(find.text('Items in cart: 1'), findsOneWidget);
      expect(find.text('Total price: £11.00'), findsOneWidget);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

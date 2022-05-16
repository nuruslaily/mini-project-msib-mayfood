import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      "Judul AppBar bertuliskan My Cart",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
        ),
      ),
    ));
  });

  testWidgets("Mencari child widget Divider", (WidgetTester tester) async {
    var childWidget = const Divider(thickness: 1,);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(child: SingleChildScrollView(child: Column(
          children: [
            Column(
              children: [
                childWidget
              ],
            )
          ],
        ),)),
      ),
    ));
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
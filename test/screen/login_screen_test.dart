import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      "Judul AppBar bertuliskan Login",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
      ),
    ));
  });
  testWidgets("TextField email and password widget test",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: ListView(
                    children: [TextFormField()],
                  ),
                )))));

    var textField = find.byType(TextFormField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, "nuruslaily88@gmail.com");
    expect(find.text("nuruslaily88@gmail.com"), findsOneWidget);
    await tester.enterText(textField, "Nurus123");
    expect(find.text("Nurus123"), findsOneWidget);
  });

  testWidgets("Mencari child widget Sizedbox", (WidgetTester tester) async {
    var childWidget = const SizedBox(
      height: 16,
    );

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: ListView(
                    children: [childWidget],
                  ),
                )))));
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets("Tombol bertuliskan Login", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: ListView(
                    children: [
                      ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )))));
    var buttonLogin = find.text("Login");
    expect(buttonLogin, findsOneWidget);
    await tester.tap(buttonLogin);
    await tester.pump();
  });
}

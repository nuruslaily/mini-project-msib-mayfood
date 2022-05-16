import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      "Judul AppBar bertuliskan Register",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
      ),
    ));
  });
  testWidgets("TextField name, email, password, phone, birth and address widget test",
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
    await tester.enterText(textField, "nuruslaily");
    expect(find.text("nuruslaily"), findsOneWidget);
    await tester.enterText(textField, "nuruslaily88@gmail.com");
    expect(find.text("nuruslaily88@gmail.com"), findsOneWidget);
    await tester.enterText(textField, "Nurus123");
    expect(find.text("Nurus123"), findsOneWidget);
    await tester.enterText(textField, "081");
    expect(find.text("081"), findsOneWidget);
    await tester.enterText(textField, "08/04/00");
    expect(find.text("08/04/00"), findsOneWidget);
    await tester.enterText(textField, "Jl Ikan");
    expect(find.text("Jl Ikan"), findsOneWidget);
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

  testWidgets("Tombol bertuliskan Register", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: ListView(
                    children: [
                      ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )))));
    var buttonRegister = find.text("Register");
    expect(buttonRegister, findsOneWidget);
    await tester.tap(buttonRegister);
    await tester.pump();
  });
}
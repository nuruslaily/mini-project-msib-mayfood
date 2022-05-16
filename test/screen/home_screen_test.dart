import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      "Judul bertuliskan Welcome to our delivery, dan terdapat slogan text home cooking delivery",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Text("Welcome"),
              Text("to our delivery"),
              Text("home cooking delivery")
            ],
          ),
        ),
      ),
    ));
  });

  testWidgets("Mencari child widget Sizedbox", (WidgetTester tester) async {
    var childWidgetPertama = const SizedBox(
      height: 20,
    );
    var childWidgetKedua = const SizedBox(
      height: 10,
    );
    var childWidgetKetiga = const SizedBox(
      height: 40,
    );
    var childWidgetKeempat = const SizedBox(
      height: 40,
    );
    var childWidgetKelima = const SizedBox(
      height: 40,
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              childWidgetPertama,
              childWidgetKedua,
              childWidgetKetiga,
              childWidgetKeempat,
              childWidgetKelima
            ],
          ),
        ),
      ),
    ));
    expect(find.byWidget(childWidgetPertama), findsOneWidget);
    expect(find.byWidget(childWidgetKedua), findsOneWidget);
    expect(find.byWidget(childWidgetKetiga), findsOneWidget);
    expect(find.byWidget(childWidgetKeempat), findsOneWidget);
    expect(find.byWidget(childWidgetKelima), findsOneWidget);
  });
  testWidgets("Tombol bertuliskan Login dan Register", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('Register'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    ));
    var buttonLogin = find.text("Login");
    var buttonRegister = find.text("Register");
    expect(buttonLogin, findsOneWidget);
    expect(buttonRegister, findsOneWidget);
    await tester.tap(buttonLogin);
    await tester.pump();
    await tester.tap(buttonRegister);
    await tester.pump();
  });
}

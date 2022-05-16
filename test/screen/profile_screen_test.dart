import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods/model/user_model.dart';

void main() {
testWidgets(
      "Judul AppBar bertuliskan Profile",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
      ),
    ));
  });

  testWidgets("Mencari child widget Sizedbox", (WidgetTester tester) async {
    var childWidget = const SizedBox(
      height: 24,
    );

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ListView(children: [childWidget],))));
    expect(find.byWidget(childWidget), findsOneWidget);
  });  

  testWidgets(
      "Profile terdapat text username, email, phone, birth, address",
      (WidgetTester tester) async {
        UserModel user = UserModel(username: 'a', email: 'b', password: 'c', phone: 'd', birth: 'e', address: 'f');
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(children: [
          Column(
            children: [
              Text(user.username),
              Text(user.email),
              Text(user.password),
              Text(user.phone),
              Text(user.birth),
              Text(user.address)
            ],
          )
        ],),
      ),
    ));
  });

}
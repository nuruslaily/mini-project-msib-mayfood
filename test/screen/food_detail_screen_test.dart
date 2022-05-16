import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/food/food_detail_screen.dart';

void main() {
  Food food = Food(name: 'a', category: 'b', price: 10.0, description: 'c', image: 'd');

  testWidgets(
      "Judul AppBar bertuliskan Nama Makanan",
      (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text(food.name),
        ),
      ),
    ));
  });

  testWidgets(
      "Isi dari detail terdapat deskripsi",
      (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(child: Column(
          children: [
            Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    subtitle: Text(food.description),
                  ),
                ],
              ),
            ),
          )],
        )),
      ),
    ));
  });

  testWidgets("Tombol berisi icon shopping cart", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButton(onPressed: () {}, 
                    child: IconButton(onPressed: (){}, 
                    icon: const Icon(Icons.shopping_cart)))
                  ]
                ),
              ),
            ),
          ],
        )),
      ),
    ));
    var buttonIconCart = find.byIcon(Icons.shopping_cart);
    expect(buttonIconCart, findsOneWidget);
    await tester.tap(buttonIconCart);
    await tester.pump();
  });

  testWidgets("Tombol favorite berbentuk love", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [ListTile(
                   trailing: IconButton(onPressed: (){}, 
                   icon: const Icon(Icons.favorite)),
                  )],
                ),
              ),
        ),
            ],
          )),
      ),
    ));
  });

  testWidgets("Pada detail menampilkan harga dan perubahan total harga", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(food.price.toString())
                  ]
                ),
              ),
        ),
            ],
          )),
      ),
    ));
  });

  testWidgets("Mencari child widget Divider", (WidgetTester tester) async {
    var childWidget = const Divider(thickness: 1,);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    childWidget
                  ]
                ),
              ),
        ),
            ],
          )),
      ),
    ));
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
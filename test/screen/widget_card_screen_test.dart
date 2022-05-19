import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods/model/food_model.dart';

void main() {
  Food food = Food(name: 'a', category: 'b', price: 10.0, description: 'c', image: 'https://raw.githubusercontent.com/nuruslaily/pelatihan/main/img/ceker-pedas.jpeg');

  testWidgets(
      "Pada card berisi nama makanan",
      (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                      key: Key(food.id.toString()),
                      child: Text(food.name)
                    )
                  ],
                ),
              )
            )
          ]
        )
        )
    ));
  });

  testWidgets(
      "Pada card berisi button icon cart",
      (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      IconButton(
                      onPressed: (){}, 
                      icon: Icon(Icons.shopping_cart))
                    ],
                  ),
                )
              )
            ]
          ),
        )
        )
    ));

    var buttonIconCart = find.byIcon(Icons.shopping_cart);
    expect(buttonIconCart, findsOneWidget);
    await tester.tap(buttonIconCart);
    await tester.pump();
  });
  
  
}
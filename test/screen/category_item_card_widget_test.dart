import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods/model/food_model.dart';

void main() {
  Food food = Food(name: 'a', category: 'b', price: 10.0, description: 'c', image: 'https://raw.githubusercontent.com/nuruslaily/pelatihan/main/img/ceker-pedas.jpeg');
  
  // testWidgets(
  //     "Pada card category screen berisi foto makanan",
  //     (WidgetTester tester) async {

  //   await tester.pumpWidget(MaterialApp(
  //     home: ClipRRect(
  //       clipBehavior: Clip.hardEdge,
  //       child: Card(
  //         child: Column(
  //           children: [
  //             Container(
  //               child: Image.network(
  //                 food.image
  //               ))
  //           ]
  //         ),
  //       )
  //       )
  //   ));
  // });

  testWidgets(
      "Pada card category screen berisi nama makanan",
      (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Text(food.name),
                ))
            ]
          ),
        )
        )
    ));
  });
}
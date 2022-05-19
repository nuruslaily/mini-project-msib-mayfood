import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods/model/food_model.dart';

void main() {
  Food food = Food(name: 'a', category: 'b', price: 10.0, description: 'c', image: 'https://raw.githubusercontent.com/nuruslaily/pelatihan/main/img/ceker-pedas.jpeg');
  testWidgets(
      "Judul AppBar bertuliskan Favorite",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
        ),
      ),
    ));
  });

  testWidgets(
      "Terdapat text yang berisi nama dan deskripsi makanan favorite",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(food.name),
                        Text(food.description)
                      ],
                    )
                  ],
                )
              )
            ]),
        ),
      ),
    ));
  });
  
  testWidgets(
      "Terdapat childwidget Sizedbox",
      (WidgetTester tester) async {
        
        var childWidget = const SizedBox(
      height: 4,
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        childWidget
                      ],
                    )
                  ],
                )
              )
            ]),
        ),
      ),
    ));
    expect(find.byWidget(childWidget), findsOneWidget);
  });
  

}
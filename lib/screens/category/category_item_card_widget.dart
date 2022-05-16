import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';

class CategoryItemCardWidget extends StatelessWidget {
  CategoryItemCardWidget(
      {Key? key, required this.item, this.color = Colors.red})
      : super(key: key);
  final Food item;

  final height = 200.0;

  final width = 175.0;

  final Color? borderColor = Colors.brown[100];
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Card(
        color: borderColor,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 90,
              width: 160,
              child: imageWidget(),
            ),
            Expanded(
              child: Container(
                child: Text(
                  item.name,
                  style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      color: Color.fromARGB(255, 41, 39, 39),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Image.network(
      item.image,
      fit: BoxFit.fill,
    );
  }
}

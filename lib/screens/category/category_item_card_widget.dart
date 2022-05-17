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
      clipBehavior: Clip.antiAlias,
      child: Card(
        color: borderColor,
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: 150,
                width: 160,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                  imageWidget(),
                  Container(
                    alignment: Alignment.topCenter,
                    width: 100,
                    height: 100,
                    child: Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Text(
                            item.name,
                            style: const TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                color: Color.fromARGB(255, 41, 39, 39),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                      ),
                      ),
                ])),
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

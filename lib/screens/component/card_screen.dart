import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/component/item_counter.dart';

class ProductCards extends StatefulWidget {
  const ProductCards(
      {Key? key,
      required this.menu,
      p, required this.isAdded, required this.onTap})
      : super(key: key);
  final Food menu;
  final bool isAdded;
  final Function() onTap;

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    // FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
    // int? index;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(widget.menu.image, fit: BoxFit.fill,),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    key: Key(widget.menu.id.toString()),
                    child: Text(
                      widget.menu.name,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onTap,
                    icon: widget.isAdded
                        ? Icon(
                            Icons.shopping_cart,
                            color: Colors.red[900],
                          )
                        : const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

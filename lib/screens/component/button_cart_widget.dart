import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class ButtonCart extends StatefulWidget {
  final Function() onTap;

  const ButtonCart({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<ButtonCart> createState() => _ButtonCartState();
}

class _ButtonCartState extends State<ButtonCart> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
        child: Text('Add to Cart'));
  }
}

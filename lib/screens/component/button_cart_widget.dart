import 'package:flutter/material.dart';

class ButtonCart extends StatefulWidget {
  final Function() onTap;

  const ButtonCart({Key? key, required this.onTap}) : super(key: key);

  @override
  State<ButtonCart> createState() => _ButtonCartState();
}

class _ButtonCartState extends State<ButtonCart> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onTap, child: const Text('Add to Cart'));
  }
}

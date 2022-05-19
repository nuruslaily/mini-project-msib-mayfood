import 'package:flutter/material.dart';

class ItemCounter extends StatefulWidget {
  final Function onAmountChanged;
  final int jumlah;
  const ItemCounter({Key? key, required this.onAmountChanged, required this.jumlah})
      : super(key: key);

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int amount = 1;

  @override
  void initState() {
    amount = widget.jumlah;
    // updateParent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('amount item counter: $amount');
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: Colors.grey, onPressed: decrementAmount),
        const SizedBox(
          width: 18,
        ),
        SizedBox(
            width: 30,
            child: Center(
                child: getText(
                    text: amount.toString(), fontSize: 15, isBold: true))),
        const SizedBox(width: 18),
        iconWidget(Icons.add,
            iconColor: Colors.blue, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 0) return;
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void updateParent() {
    widget.onAmountChanged(amount);
  }

  Widget iconWidget(IconData iconData, {required Color iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xffE2E2E2),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
      required double fontSize,
      bool isBold = false,
      color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/component/item_counter.dart';

class ChartItemWidget extends StatefulWidget {
  const ChartItemWidget({Key? key, required this.item}) : super(key: key);
  final Food item;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = const Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.name, style: const TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.item.description, style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),),
                const SizedBox(
                  height: 12,
                ),
                const Spacer(),
                ItemCounter(
                  onAmountChanged: (newAmount) {
                    setState(() {
                      amount = newAmount;
                    });
                  },
                )
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 25,
                ),
                const Spacer(
                  flex: 5,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    "Rp${getPrice().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.right,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return SizedBox(
      width: 100,
      child: Image.network(widget.item.image),
    );
  }

  double getPrice() {
    return widget.item.price * amount;
  }
}

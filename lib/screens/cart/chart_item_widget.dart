import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/cart/cart_screen.dart';
import 'package:foods/screens/component/item_counter.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

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
    FoodViewModel modelView = Provider.of<FoodViewModel>(context);

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: IntrinsicHeight(
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          direction: Axis.vertical,
          children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
                size: 15,
              ),
              onPressed: () {
                handleDeleteFoodCart(modelView);
              },
            ),
              ],
            ),
            imageWidget(),
            Flex(
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    "Rp${getPrice().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Text(
                    widget.item.description,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                Text(
                  "${getAmount(modelView).toInt()}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
                // ItemCounter(
                //   onAmountChanged: (newAmount) {
                //     setState(() {
                //       amount = newAmount;
                //     });
                //   },
                // )
              ],
            ),
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

  handleDeleteFoodCart(FoodViewModel viewModel) {
    for (var i = 0; i < viewModel.cartList.length; i++) {
      if (viewModel.cartList[i].id == widget.item.id) {
        setState(() {
          viewModel.cartList.removeAt(i);
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        });
      }
    }
  }

  num getPrice() {
    return widget.item.price * amount;
  }

  double getAmount(FoodViewModel modelView) {
    final totalPrice = widget.item.price;
    final hargaAwal =
        modelView.foods.where((e) => e.id == widget.item.id).toList();

    return totalPrice / hargaAwal[0].price;
  }
}

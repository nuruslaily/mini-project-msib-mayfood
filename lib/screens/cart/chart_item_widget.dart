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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 25,
                  ),
                  onPressed: () {
                    handleDeleteFoodCart(modelView);
                  },
                ),
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.item.description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    "Rp${getPrice().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("${getAmount(modelView).toInt()}", style: TextStyle(fontWeight: FontWeight.bold),)
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
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartScreen()));
        }); 
      }
    }
  }

  double getPrice() {
    return widget.item.price * amount;
  }

  double getAmount(FoodViewModel modelView) {
    final totalPrice = widget.item.price;
    final hargaAwal =
        modelView.foods.where((e) => e.id == widget.item.id).toList();

    return totalPrice / hargaAwal[0].price;
  }
}

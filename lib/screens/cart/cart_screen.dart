import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/cart/chart_item_widget.dart';
import 'package:foods/screens/cart/checkout_bottom_sheet.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  Food? food;
  CartScreen({Key? key,this.food}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    final cartList =
        Provider.of<FoodViewModel>(context, listen: false).cartList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            "My Cart",
            style: TextStyle(fontSize: 17, fontFamily: 'Merriweather', color: Colors.white),
          ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Column(
              children: getChildrenWithSeparator(
            addToLastChild: false,
            widgets: cartList.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: double.maxFinite,
                child: ChartItemWidget(item: e),
              );
            }).toList(),
            separator: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                thickness: 1,
              ),
            ),
          )),
          const Divider(
            thickness: 1,
          ),
          getCheckoutButton(context),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: cartList.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(
          //           cartList[index].name,
          //           style: const TextStyle(fontSize: 20),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Pesan Sekarang',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
        ],
      ))),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ElevatedButton(
          child: const Text("Go To Check Out",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
              )),
          // trailingWidget: getButtonPriceWidget(),
          onPressed: () {
            showBottomSheet(context);
          },
        ));
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.red[800],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "Rp${getPrice().toStringAsFixed(2)}",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return const CheckoutBottomSheet();
        });
  }
  double getPrice() {
    return widget.food!.price * amount;
  }
}

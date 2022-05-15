import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/cart/cart_screen.dart';
import 'package:foods/screens/component/item_counter.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final Food detailFood;
  final String heroSuffix;
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String image;

  const FoodDetailScreen(
      {Key? key,
      required this.detailFood,
      required this.heroSuffix,
      required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    FoodViewModel modelView = Provider.of<FoodViewModel>(context);

    final checkCart =
        modelView.cartList.where((e) => e.id == widget.id).toList();
    // print(checkCart.length);
    print((checkCart.isNotEmpty) ? checkCart[0].price : 'kosong');

    if (checkCart.isNotEmpty) {
      setState(() {
        amount = (checkCart[0].price / widget.price).toInt();
      });
    }
    // final modelView = Provider.of<FoodViewModel>(context, listen: false);
    // final item = FoodViewModel();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,
            style: const TextStyle(fontFamily: 'Merriweather', fontSize: 17)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            getImageHeaderWidget(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ListTile(
                        subtitle: Text(widget.description,
                            style: const TextStyle(fontSize: 16)),
                        trailing: FavoriteButton(
                          id: widget.id,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          ItemCounter(
                            onAmountChanged: (newAmount) {
                              setState(() {
                                amount = newAmount;
                              });
                            },
                          ),
                          const Spacer(),
                          Text(
                            "Rp${getTotalPrice().toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      const Divider(thickness: 1),
                      getProductDataRowWidget(
                        "Review",
                        customWidget: ratingWidget(),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {},
                          child: (checkCart.isNotEmpty)
                              ? null
                              : IconButton(
                                  onPressed: () => getButtonAddCart(modelView),
                                  icon: const Icon(Icons.shopping_cart))),
                      const Spacer(),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  getButtonAddCart(FoodViewModel viewModel) {
    final foodItem = Food(
        id: widget.id,
        name: widget.name,
        category: widget.category,
        price: widget.price * amount,
        description: widget.description,
        image: widget.image);

    setState(() {
      viewModel.addCart(foodItem);
    });

    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return CartScreen();
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.0, end: 1.0);
        return FadeTransition(opacity: animation.drive(tween), child: child);
      }),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
            colors: [
              Colors.red.withOpacity(0.1),
              Colors.red.withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Hero(
        tag: "FoodItem:" + widget.detailFood.name + "-" + (widget.heroSuffix),
        child: Image.network(widget.detailFood.image),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Spacer(),
          if (customWidget != null) ...[
            customWidget,
            const SizedBox(
              width: 20,
            )
          ],
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return const Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    return amount.toDouble() * widget.detailFood.price;
  }
}

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FoodViewModel modelView = Provider.of<FoodViewModel>(context);
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          getButtonFavoriteMenu(modelView);
          isFavorite = !isFavorite;
        });
      },
    );
  }

  getButtonFavoriteMenu(FoodViewModel viewModel) {
    for (var food in viewModel.foods) {
      if (food.id == widget.id) {
        setState(() {
          viewModel.favoriteFood(food);
        });
      }
    }
  }
}

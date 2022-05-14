import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            "Favorite",
            style: TextStyle(fontSize: 17, fontFamily: 'Merriweather'),
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
      body: Container(
        child:  getFavorite(context)
      ),
    );
    }
    
    getFavorite(BuildContext context){
      FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
      final favorite =
        Provider.of<FoodViewModel>(context, listen: false).favorite;
      if (viewModel.foods.isEmpty) {
        return const Center(
                child: Text("No Favorite Items",
                  style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7C7C7C),),
                ),
              );
      } else {
        return Column(
          children: getChildrenWithSeparator(
            addToLastChild: false,
            widgets: favorite.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: double.maxFinite,
                child: FavoriteCardWidget(item: e),
              );
            }).toList(),
            separator: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
            ),
          )
        );
      }
}
}


class FavoriteCardWidget extends StatefulWidget {
  const FavoriteCardWidget({Key? key, required this.item}) : super(key: key);
  final Food item;

  @override
  _FavoriteCardWidgetState createState() => _FavoriteCardWidgetState();
}

class _FavoriteCardWidgetState extends State<FavoriteCardWidget> {
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.name, style: const TextStyle( fontSize: 16,
                  fontWeight: FontWeight.bold,),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(widget.item.description, style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),),
                const Divider()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return SizedBox(
      width: 120,
      child: Image.network(widget.item.image),
    );
  }

}



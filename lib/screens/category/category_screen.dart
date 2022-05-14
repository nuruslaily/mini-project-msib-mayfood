import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/category/category_item_card_widget.dart';
import 'package:foods/screens/food/food_detail_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FilterScreen(category: ,)),
              // );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 25),
              child: const Icon(
                Icons.sort,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: const Text(
            "Category", style: TextStyle(fontFamily: 'Merriweather', color: Colors.white,
            fontSize: 17),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        // I only need two card horizontally
        children: viewModel.foods.asMap().entries.map<Widget>((e) {
          Food menu = e.value;
          return GestureDetector(
            onTap: () {
              onItemClicked(context, menu);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: CategoryItemCardWidget(
                item: menu,
                // heroSuffix: "explore_screen",
              ),
            ),
          );
        }).toList(),
        // staggeredTiles:
        //     categoryItems.map<StaggeredTile>((_) => StaggeredTile.fit(2)).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 0.0, // add some space
      ),
    );
  }

  void onItemClicked(BuildContext context, Food category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(
          name: category.name, price: category.price, description: category.description, image: category.image, category: category, heroSuffix: "explore", id: category.id!,
        ),
      ),
    );
  }
}
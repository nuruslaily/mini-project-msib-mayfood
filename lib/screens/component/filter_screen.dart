import 'package:flutter/material.dart';
import 'package:foods/screens/category/category_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {
  String? pilihan;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Filters",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getLabel("Categories"),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    child: _buildChips(),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text(
                "Apply Filter",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                viewModel.filteredFood.clear();
                var foodChoice = (viewModel.category.length > 0)
                    ? viewModel.category[viewModel.category.length - 1]
                    : [];
                final filteredFoodsss = (viewModel.category.length > 0)
                    ? viewModel.foods
                        .where((e) => e.category == foodChoice)
                        .toList()
                    : viewModel.foods;

                for (var element in filteredFoodsss) {
                  viewModel.filteredFood.add(element);
                  // print(element.name);
                }
                // if (pilihan == widget.category) {
                //   for (var food in viewModel.foods) {
                //     if (food.category == widget.category) {
                //       setState(() {
                //         viewModel.category;
                //       });
                //     }
                //   }
                // }
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChips() {
    List<String> food = ['Snack', 'Makanan Berat', 'Minuman'];
    FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
    List<Widget> chips = [];
    var foodChoice = (viewModel.category.length > 0)
        ? viewModel.category[viewModel.category.length - 1]
        : [];

    for (int i = 0; i < food.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: foodChoice == food[i],
        label: Text(food[i].toString(), style: TextStyle(color: Colors.white)),
        avatar: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Text(food[i]),
        ),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              viewModel.category.add(food[i]);
              _selectedIndex = i;
            }
          });

          print(viewModel.category[viewModel.category.length - 1]);
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }
    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget getLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String text;

  const OptionItem({Key? key, required this.text}) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;
        });
      },
      child: Row(
        children: [
          getCheckBox(),
          const SizedBox(
            width: 12,
          ),
          getTextWidget(),
        ],
      ),
    );
  }

  Widget getTextWidget() {
    return Text(
      widget.text,
      style: TextStyle(
        color: checked ? Colors.blue : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget getCheckBox() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        width: 25,
        height: 25,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: checked ? 0 : 1.5, color: const Color(0xffB1B1B1)),
              borderRadius: BorderRadius.circular(8),
              color: checked ? Colors.blue : Colors.transparent),
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.transparent,
            ),
            child: Checkbox(
              value: checked,
              onChanged: (state) {
                setState(() {
                  // widget.category = state;
                  checked = !checked;
                });
              },
              activeColor: Colors.transparent,
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          ),
        ),
      ),
    );
  }
}

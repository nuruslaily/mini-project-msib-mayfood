import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  final String category;

  const FilterScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? pilihan;
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
          child: Container(
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Filters",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
          color: Color(0xFFF2F3F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getLabel("Categories"),
            SizedBox(height: 15),
            OptionItem(text: "Snack"),
            SizedBox(height: 15),
            OptionItem(text: "Heavy Meal"),
            SizedBox(height: 15),
            OptionItem(text: "Drink"),
            SizedBox(height: 15),
            Spacer(),
            ElevatedButton(
              child: Text(
                "Apply Filter",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                if(pilihan == widget.category){
                  for (var food in viewModel.foods) {
                  if (food.category == widget.category) {
                    setState(() {
                      viewModel.category;
                    });
                  }
                }
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget getLabel(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String text;

  OptionItem({Key? key, required this.text}) : super(key: key);

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
      child: Container(
        child: Row(
          children: [
            getCheckBox(),
            SizedBox(
              width: 12,
            ),
            getTextWidget(),
          ],
        ),
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
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        width: 25,
        height: 25,
        child: Container(
          decoration: new BoxDecoration(
              border: Border.all(
                  width: checked ? 0 : 1.5, color: Color(0xffB1B1B1)),
              borderRadius: new BorderRadius.circular(8),
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

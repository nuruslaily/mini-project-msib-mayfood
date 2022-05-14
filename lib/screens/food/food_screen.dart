import 'package:flutter/material.dart';
import 'package:foods/model/view_state.dart';
import 'package:foods/screens/cart/cart_screen.dart';
import 'package:foods/screens/component/card_screen.dart';
import 'package:foods/screens/food/food_detail_screen.dart';
import 'package:foods/screens/component/draw_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>{
  SharedPreferences? logindata;
  String username = '';
  String email = '';
  String password = '';

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata!.getString('username').toString();
      email = logindata!.getString('email').toString();
      password = logindata!.getString('password').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FoodViewModel>(context, listen: false).getAllFoods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[100],
          appBar: AppBar(
            centerTitle: true,
            title: Text('MayFoods', style: TextStyle(fontSize: 17, fontFamily: 'Merriweather', 
            color: Colors.white)),
            backgroundColor: Colors.red,
          ),
          drawer: const DrawWidget(),
          body: const FoodList(),
    );
        
  }
}

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    FoodViewModel viewModel = Provider.of<FoodViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: body(viewModel),
    );
  }

  Widget gridView(FoodViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemCount: viewModel.foods.length,
      itemBuilder: (context, index) {
        return Consumer<FoodViewModel>(
            builder: (context, FoodViewModel item, widget) {
          final _menu = viewModel.foods[index];
          return GestureDetector(
            key: Key(_menu.id.toString()),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FoodDetailScreen(
                      id: _menu.id!,
                      name: _menu.name,
                      price: _menu.price.toDouble(),
                      description: _menu.description,
                      image: _menu.image, category: _menu, heroSuffix: "explore",);
                  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final tween = Tween(begin: 0.0, end: 1.0);
                    return FadeTransition(opacity: animation.drive(tween), child: child);
                  }
                ),
              );
            },
            child: ProductCards(
                menu: _menu,
                isAdded: item.cartList.contains(_menu),
                onTap: () {
                  setState(() {
                    item.addCart(_menu);
                  });
                }
                ),
          );
        });
      },
    );
  }

  Widget body(FoodViewModel viewModel) {
    final isLoading = viewModel.state == ViewState.loading;
    final isError = viewModel.state == ViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(child: Text('Gagal mengambil data.'));
    }

    return gridView(viewModel);
  }
}
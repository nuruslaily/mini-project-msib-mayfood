class Food {
  final int? id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String image;

  Food(
      {this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.image});
}

// List<Food> category = [
//   Food(
//     name: "Heavy Meal", 
//     image: "assets/nasi-ayam-geprek.jpeg"
//   ),
//   Food(
//     name: "Snack", 
//     image: "assets/ceker-pedas.jpeg"
//   ),
// ];

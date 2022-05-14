import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  Category({required this.id, required this.title, required this.color});
}

 List<Category> DUMMY_CATEGORIES = [
  Category(
    id: 'c1', 
    title: 'Snack', 
    color: Colors.yellow),
  Category(
    id: 'c2', 
    title: 'Meals', 
    color: Colors.green),  
  Category(
    id: 'c3', 
    title: 'Drink', 
    color: Colors.blue),  
];
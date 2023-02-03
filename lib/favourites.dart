import "package:flutter/material.dart";
import 'meal.dart';

class Favourites extends StatelessWidget {
  final List<Meal> favouriteMeal;
  const Favourites(this.favouriteMeal, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty) {
      return Center(child: Text("You have  no favourites yet"));
    } else {
      return Center(child: Text("favorites added"));
    }
  }
}

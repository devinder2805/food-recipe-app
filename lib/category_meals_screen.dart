import 'meal_item.dart';
import "package:flutter/material.dart";
import "meal.dart";

class CategoryMealScreen extends StatefulWidget {
  static const routeName = "categoryMealScreen";
  final List<Meal> availableMeal;
  final Function toggleFavourite;
  final List<Meal> favouriteMeal;
  const CategoryMealScreen(
      this.availableMeal, this.toggleFavourite, this.favouriteMeal,
      {super.key});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  var isLoaded = false;
  late String categoryId;
  late String categoryTitle;
  late List categoryMeal;

  void removeItem(String id) {
    setState(() {
      categoryMeal.removeWhere((mealItem) {
        return mealItem.id == id;
      });
    });
  }

  callMe() {
    if (!isLoaded) {
      final routeArgs =
          (ModalRoute.of(context)?.settings.arguments) as Map<String, String>;
      categoryTitle = routeArgs["title"]!;
      categoryId = routeArgs["id"]!;
      categoryMeal = widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    callMe();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            categoryMeal[index],
            removeItem,
            widget.toggleFavourite,
            widget.favouriteMeal,
          );
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}

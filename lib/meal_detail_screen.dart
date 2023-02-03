// ignore_for_file: prefer_const_literals_to_create_immutables

import 'meal.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(title: Text(routeArg.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                routeArg.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...routeArg.ingredients.map((ingredients) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ingredients,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...routeArg.steps.map((steps) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  steps,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(routeArg.id);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.delete),
      ),
    );
  }
}

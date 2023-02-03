import 'meal_detail_screen.dart';
import "tab_screen.dart";
import 'category_meals_screen.dart';
import 'package:flutter/material.dart';
import "categories_screen.dart";
import "filter_screen.dart";
import "dummy_data.dart";
import 'meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHome();
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favouriteMeal = [];

  void saveFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = dummyMeals.where((meal) {
        if (filters["gluten"]! && !meal.isGlutenFree) {
          return false;
        }
        if (filters["lactose"]! && !meal.isLactoseFree) {
          return false;
        }
        if (filters["vegan"]! && !meal.isVegan) {
          return false;
        }
        if (filters["vegetarian"]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourite(String mealId) {
    final existingIndex = favouriteMeal.indexWhere((element) {
      return element.id == mealId;
    });

    setState(() {
      if (existingIndex >= 0) {
        favouriteMeal.removeAt(existingIndex);
      } else {
        favouriteMeal.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Delimeals",
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Ubuntu",
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: "ubuntu",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
            .copyWith(secondary: const Color.fromARGB(255, 34, 122, 169)),
      ),
      home: TabScreen(favouriteMeal),
      routes: {
        TabScreen.routeName: (ctx) => CategoriesScreen(),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(availableMeals, toggleFavourite, favouriteMeal),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        FilterScreen.routeName: (ctx) => FilterScreen(filters, saveFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabScreen(favouriteMeal));
      },
    );
  }
}

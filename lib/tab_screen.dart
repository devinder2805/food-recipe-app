import 'categories_screen.dart';
import "package:flutter/material.dart";
import 'favourites.dart';
import "main_drawer.dart";

import 'meal.dart';

class TabScreen extends StatefulWidget {
  static const routeName = "tabScreen";
  final List<Meal> favouriteMeal;
  const TabScreen(this.favouriteMeal, {super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> Pages;

  int selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pages = [
      {
        "page": CategoriesScreen(),
        "title": "Categories",
      },
      {
        "page": Favourites(widget.favouriteMeal),
        "title": "favourites",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Pages[selectedPageIndex]["title"]),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_sharp),
            label: "Favourites",
          ),
        ],
      ),
      body: Pages[selectedPageIndex]["page"] as Widget,
    );
  }
}

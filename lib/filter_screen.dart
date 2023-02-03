import 'main_drawer.dart';
import "package:flutter/material.dart";

class FilterScreen extends StatefulWidget {
  static const routeName = "filterScreen";

  final Function saveFilters;
  final Map<String, bool> currentFilter;
  const FilterScreen(this.currentFilter, this.saveFilters, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    glutenFree = widget.currentFilter["gluten"] as bool;
    lactoseFree = widget.currentFilter["lactose"] as bool;
    vegan = widget.currentFilter["vegan"] as bool;
    vegetarian = widget.currentFilter["vegetarian"] as bool;
  }

  Widget buildSwitchTiles(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: (newValue) {
        updateValue(newValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Screens"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "gluten": glutenFree,
                "lactose": lactoseFree,
                "vegan": vegan,
                "vegetarian": vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(children: [
              buildSwitchTiles(
                  "Gluten-free", "Only include gluten free", glutenFree,
                  (newValue) {
                setState(() {
                  glutenFree = newValue;
                });
              }),
              buildSwitchTiles("Vegan", "Only include Vegan ", vegan,
                  (newValue) {
                setState(() {
                  vegan = newValue;
                });
              }),
              buildSwitchTiles(
                  "Vegetarian", "Only include vegetarian", vegetarian,
                  (newValue) {
                setState(() {
                  vegetarian = newValue;
                });
              }),
              buildSwitchTiles(
                  "Lactose-free", "Only include Lactose free", lactoseFree,
                  (newValue) {
                setState(() {
                  lactoseFree = newValue;
                });
              }),
            ]),
          )
        ],
      ),
    );
  }
}

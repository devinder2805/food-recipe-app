import 'filter_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, Function handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        handler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            "hello",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile(
          "Meal",
          Icons.restaurant,
          () {
            Navigator.of(context).pushReplacementNamed("/homeScreen");
          },
        ),
        buildListTile(
          "Settings",
          Icons.settings,
          () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          },
        ),
      ],
    ));
  }
}

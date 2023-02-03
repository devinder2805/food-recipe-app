import 'meal_detail_screen.dart';
import "package:flutter/material.dart";
import "meal.dart";

class MealItem extends StatefulWidget {
  final Meal mealItem;
  final Function removeItem;
  final Function toggleFavourite;
  final List<Meal> favouriteMeal;
  const MealItem(
      this.mealItem, this.removeItem, this.toggleFavourite, this.favouriteMeal,
      {super.key});

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  //bool isFavourite = false;
  String get mealComplexity {
    if (widget.mealItem.complexity == Complexity.Simple) {
      return "Simple";
    } else if (widget.mealItem.complexity == Complexity.Challenging) {
      return "Challenging";
    } else {
      return "Hard";
    }
  }

  bool isFavouriteMarked(String id) {
    return widget.favouriteMeal.any((meal) => meal.id == id);
  }

  String get mealAffordability {
    switch (widget.mealItem.affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Luxurious";
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: widget.mealItem,
    )
        .then((result) {
      if (result != null) {
        widget.removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(
                      15,
                    ),
                  ),
                  child: Image.network(
                    widget.mealItem.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 220,
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      widget.mealItem.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: isFavouriteMarked(widget.mealItem.id)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                    onPressed: () => widget.toggleFavourite(widget.mealItem.id),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 10),
                      Text("${widget.mealItem.duration} min")
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 10),
                      Text("$mealComplexity todo")
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.price_change_outlined),
                      const SizedBox(width: 10),
                      Text(mealAffordability)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

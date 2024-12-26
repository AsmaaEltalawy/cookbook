import 'package:cookbook/Components/categoryCard.dart';
import 'package:cookbook/Screens/recipesearch.dart';
import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8DC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2691E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        title: const Center(
          child: Text(
            'Cook Book',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearch(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/breakfast');
                  },
                  child: const CategoryCard(
                    categoryName: 'Breakfast',
                    icon: Icons.breakfast_dining,
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/lunch');
                  },
                  child: const CategoryCard(
                    categoryName: 'Lunch',
                    icon: Icons.lunch_dining,
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dinner');
                  },
                  child: const CategoryCard(
                    categoryName: 'Dinner',
                    icon: Icons.dinner_dining,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dessert');
                  },
                  child: const CategoryCard(
                    categoryName: 'Dessert',
                    icon: Icons.cake,
                    backgroundColor: Color(0xFFD2691E),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_recipe");
        },
        backgroundColor: const Color(0xFFD2691E),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:cookbook/Components/Recipe_card.dart';
import 'package:cookbook/data/recipesdatabase.dart';
import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/data/models/recipemodel.dart';
import 'package:provider/provider.dart';

class RecipeSearch extends SearchDelegate<String> {
  final RecipeDataBase recipeDB = RecipeDataBase();
  List<RecipeModel> allRecipes = [];

  RecipeSearch() {
    allRecipes = recipeDB.loadRecipes();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allRecipes
        .where((recipe) =>
            recipe.recipeName.toLowerCase().contains(query.toLowerCase()) ||
            recipe.ingredients.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.pink.shade50, // تغيير لون خلفية النتائج
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final recipe = results[index];
          return RecipeCard(
            recipeName: recipe.recipeName,
            categoryName: recipe.selectedCategory,
            cookingTime: recipe.cookingTime.toString(),
            imagePath: recipe.imagePath,
            instructions: recipe.instructions,
            ingredients: recipe.ingredients,
            selectedCategory: recipe.selectedCategory, index: index,
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final suggestions = provider.searchRecipes(query);

    return AnimatedOpacity(
      opacity: query.isEmpty ? 0.0 : 1.0, // Opacity changes based on query
      duration: const Duration(seconds: 1),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFFF8DC), Color(0xffFFF8DC), Color(0xFFD2691E)],
            // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final recipe = suggestions[index];
            return RecipeCard(
              recipeName: recipe.recipeName,
              categoryName: recipe.selectedCategory,
              cookingTime: recipe.cookingTime.toString(),
              imagePath: recipe.imagePath,
              instructions: recipe.instructions,
              ingredients: recipe.ingredients,
              selectedCategory: recipe.selectedCategory, index: index,
            );
          },
        ),
      ),
    );
  }
}

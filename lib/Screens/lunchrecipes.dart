import 'package:cookbook/Components/Recipe_card.dart';
import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LunchRecipes extends StatelessWidget {
  const LunchRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);
    recipeProvider.loadRecipes();
    var lunchRecipes = recipeProvider.getRecipesByCategory("Lunch");

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
              'Lunch Recipes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: lunchRecipes.length,
          itemBuilder: (context, index) {
            var recipe = lunchRecipes[index];
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
        ));
  }
}

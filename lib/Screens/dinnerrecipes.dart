import 'package:cookbook/Components/Recipe_card.dart';
import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DinnerRecipes extends StatelessWidget {
  const DinnerRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);
    var dinnerRecipes = recipeProvider.getRecipesByCategory("Dinner");

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
            'Dinner Recipes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dinnerRecipes.length,
        itemBuilder: (context, index) {
          var recipe = dinnerRecipes[index];
          return RecipeCard(
            recipeName: recipe.recipeName,
            categoryName: recipe.selectedCategory,
            cookingTime: recipe.cookingTime.toString(),
            imagePath: recipe.image,
          );
        },
      ),
    );
  }
}
import 'package:cookbook/data/models/recipemodel.dart';
import 'package:hive/hive.dart';

class RecipeDataBase {
  final box = Hive.box<RecipeModel>('recipeBox');

  List<RecipeModel> loadRecipes() {
    return box.values.toList();
  }

  void addRecipe(RecipeModel recipe) {
    box.add(recipe);
  }

  void delete(int index) {
    box.deleteAt(index); // Deletes recipe by index
  }

  List<RecipeModel> searchRecipes(String query) {
    final recipes = box.values.toList();
    return recipes
        .where((recipe) =>
    recipe.recipeName.toLowerCase().contains(query.toLowerCase()) ||
        recipe.ingredients.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

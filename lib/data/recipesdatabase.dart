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
    box.delete(index);
  }
}

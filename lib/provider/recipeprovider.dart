import 'package:cookbook/data/models/recipemodel.dart';
import 'package:cookbook/data/recipesdatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class RecipeProvider with ChangeNotifier {
  var recipesDatabase = RecipeDataBase();
  String selectedCategory = '';
  List<RecipeModel> recipeList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController preTimeController = TextEditingController();
  TextEditingController cookingTimeController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  String imagePath = '';

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      print('IMAGE PATH : $imagePath');
      notifyListeners();
    }
  }

  void updateImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  void updateSelectedCategory(String newCategory) {
    selectedCategory = newCategory;
    notifyListeners();
  }

  void loadRecipes() {
    recipeList = recipesDatabase.loadRecipes();
    notifyListeners();
  }

  void saveRecipe() {
    var newRecipe = RecipeModel(
      selectedCategory: selectedCategory,
      recipeName: nameController.text,
      imagePath: imagePath,
      preparationTime: _parseTime(preTimeController.text),
      cookingTime: _parseTime(cookingTimeController.text),
      instructions: instructionsController.text,
      ingredients: ingredientsController.text,
    );
    recipesDatabase.addRecipe(newRecipe);
    recipeList.add(newRecipe);
    notifyListeners();
    clearControllers();
  }

  void clearControllers() {
    nameController.clear();
    cookingTimeController.clear();
    instructionsController.clear();
    ingredientsController.clear();
    preTimeController.clear();
    selectedCategory = "";
    imagePath='' ;
  }

  int _parseTime(String timeText) {
    if (timeText.isEmpty || int.tryParse(timeText) == null) {
      return 0;
    }
    return int.parse(timeText);
  }

  List<RecipeModel> getRecipesByCategory(String category) {
    return recipeList
        .where((recipe) => recipe.selectedCategory == category)
        .toList();
  }
}

import 'package:hive_flutter/hive_flutter.dart';

part "recipemodel.g.dart";

@HiveType(typeId: 0)
class RecipeModel extends HiveObject {
  @HiveField(0)
  final String recipeName;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final int preparationTime;

  @HiveField(3)
  final int cookingTime;

  @HiveField(4)
  final String instructions;

  @HiveField(5)
  final String ingredients;
  @HiveField(6)
  final String selectedCategory;

  RecipeModel(
      {required this.selectedCategory,
      required this.recipeName,
      required this.image,
      required this.preparationTime,
      required this.cookingTime,
      required this.instructions,
      required this.ingredients});
}

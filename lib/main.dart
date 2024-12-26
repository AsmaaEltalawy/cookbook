import 'package:cookbook/Screens/addrecipe.dart';
import 'package:cookbook/Screens/breakfastrecipes.dart';
import 'package:cookbook/Screens/dessertrecipes.dart';
import 'package:cookbook/Screens/dinnerrecipes.dart';
import 'package:cookbook/Screens/library.dart';
import 'package:cookbook/Screens/lunchrecipes.dart';
import 'package:cookbook/Screens/recipedetails.dart';
import 'package:cookbook/data/models/recipemodel.dart';
import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeModelAdapter());
  await Hive.openBox<RecipeModel>('recipeBox');
  runApp(ChangeNotifierProvider(
    create: (context) => RecipeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Library(),
      routes: {
        "/add_recipe": (context) => AddRecipe(),
        '/breakfast': (context) => const BreakFastRecipes(),
        '/lunch': (context) => const LunchRecipes(),
        '/dinner': (context) => const DinnerRecipes(),
        '/dessert': (context) => const DessertRecipes(),
        '/recipe_details': (context) => const RecipeDetails()
      },
    );
  }
}

import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({super.key});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    // Delay showing details for animation
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showDetails = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var recipeProvider = Provider.of<RecipeProvider>(context);
    final int index = arguments['index'];
    final String recipeName = arguments['recipeName'] ?? "";
    final String categoryName = arguments['categoryName'] ?? "";
    final String cookingTime = arguments['cookingTime'] ?? "";
    final String ingredients = arguments['ingredients'] ?? "";
    final String instructions = arguments['instructions'] ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2691E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        title: Center(
          child: Text(
            recipeName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // يملى الصفحة بالكامل
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFFF8DC), Color(0xffFFF8DC), Color(0xFFD2691E)],
            // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            switchInCurve: Curves.easeInOut,
            child: _showDetails
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated recipe name
                      _buildAnimatedHeader(recipeName),
                      const SizedBox(height: 16),

                      // Info table
                      _buildInfoTable(categoryName, cookingTime),
                      const SizedBox(height: 16),

                      // Ingredients
                      _buildSectionTitle('Ingredients'),
                      const SizedBox(height: 8),
                      _buildSlidingText(ingredients),
                      const SizedBox(height: 16),

                      // Instructions
                      _buildSectionTitle('Instructions'),
                      const SizedBox(height: 8),
                      _buildSlidingText(instructions),
                      const SizedBox(height: 30,),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:const Color(0xFFD2691E), // Red color for delete
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Recipe'),
                                content: const Text(
                                    'Are you sure you want to delete this recipe?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    // Close the dialog
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      recipeProvider
                                          .deleteRecipe(index); // Delete recipe
                                      Navigator.pop(context); // Close the dialog
                                      Navigator.pop(
                                          context); // Go back to the previous screen
                                    },
                                    child: const Text(
                                      'Delete',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Delete Recipe',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD2691E),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(String title) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE9E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFFD2691E),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoTable(String categoryName, String cookingTime) {
    return Table(
      border: TableBorder.all(color: Colors.black12, width: 1),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          children: [
            _buildTableCell('Category'),
            _buildTableCell(categoryName),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Cooking Time'),
            _buildTableCell('$cookingTime minutes'),
          ],
        ),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSlidingText(String content) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFD2691E),
      ),
    );
  }
}

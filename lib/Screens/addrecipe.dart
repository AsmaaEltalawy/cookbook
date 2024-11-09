import 'dart:io';
import 'package:cookbook/provider/recipeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // إضافة المكتبة

class AddRecipe extends StatelessWidget {
  AddRecipe({super.key});

  final List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert',
  ];

  // GlobalKey for the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to open gallery and pick an image
  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Update the image path in the provider
      var provider = Provider.of<RecipeProvider>(context, listen: false);
      provider.updateImagePath(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RecipeProvider>(context);

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
            'Add Recipe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recipe Category',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: provider.selectedCategory.isEmpty
                      ? null
                      : provider.selectedCategory,
                  hint: const Text('Select a category'),
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    provider.updateSelectedCategory(newValue!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recipe Name',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                customTextField('Enter recipe name', provider.nameController),
                const SizedBox(height: 10),
                const Text(
                  'Image',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => provider.pickImageFromGallery(), // عند النقر يفتح الجاليري
                  child: AbsorbPointer(
                    child: customTextField(
                      provider.imagePath == null ? 'Tap to select an image' : 'Image selected',
                      TextEditingController(text: provider.imagePath ?? ''),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Preparation Time',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                customTextField('Enter preparation time (e.g., 15 mins)', provider.preTimeController),
                const SizedBox(height: 10),
                const Text(
                  'Cooking Time',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                customTextField('Enter cooking time (e.g., 30 mins)', provider.cookingTimeController),
                const SizedBox(height: 10),
                const Text(
                  'Ingredients',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                customTextField('Enter ingredients, separated by commas', provider.ingredientsController),
                const SizedBox(height: 10),
                const Text(
                  'Instructions',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD2691E)),
                ),
                const SizedBox(height: 8),
                customTextField('Enter step-by-step instructions', provider.instructionsController),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate the form fields
                        if (_formKey.currentState?.validate() ?? false) {
                          // If form is valid, save the recipe
                          provider.saveRecipe();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Recipe saved!')),
                          );
                        } else {
                          // If form is invalid, show a message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all fields correctly.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD2691E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Save Recipe',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField(String hint, controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFD2691E), width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field cannot be empty';
      }
      return null;
    },
  );
}


import 'food_entry.dart';

class FoodDatabase {
  static final List<Map<String, dynamic>> _foods = [
    // Fruits
    {
      'name': 'Apple',
      'calories_per_100g': 52,
      'protein_per_100g': 0.3,
      'carbs_per_100g': 14,
      'fat_per_100g': 0.2,
      'sugar_per_100g': 10.4,
      'category': 'Fruit',
      'default_unit': 'piece',
      'default_quantity': 150, // average apple weight
    },
    {
      'name': 'Banana',
      'calories_per_100g': 89,
      'protein_per_100g': 1.1,
      'carbs_per_100g': 23,
      'fat_per_100g': 0.3,
      'sugar_per_100g': 12.2,
      'category': 'Fruit',
      'default_unit': 'piece',
      'default_quantity': 120,
    },
    {
      'name': 'Orange',
      'calories_per_100g': 47,
      'protein_per_100g': 0.9,
      'carbs_per_100g': 12,
      'fat_per_100g': 0.1,
      'sugar_per_100g': 9.4,
      'category': 'Fruit',
      'default_unit': 'piece',
      'default_quantity': 130,
    },
    {
      'name': 'Strawberries',
      'calories_per_100g': 32,
      'protein_per_100g': 0.7,
      'carbs_per_100g': 8,
      'fat_per_100g': 0.3,
      'sugar_per_100g': 4.9,
      'category': 'Fruit',
      'default_unit': 'cup',
      'default_quantity': 150,
    },
    {
      'name': 'Grapes',
      'calories_per_100g': 62,
      'protein_per_100g': 0.6,
      'carbs_per_100g': 16,
      'fat_per_100g': 0.2,
      'sugar_per_100g': 16.0,
      'category': 'Fruit',
      'default_unit': 'cup',
      'default_quantity': 150,
    },

    // Vegetables
    {
      'name': 'Broccoli',
      'calories_per_100g': 34,
      'protein_per_100g': 2.8,
      'carbs_per_100g': 7,
      'fat_per_100g': 0.4,
      'sugar_per_100g': 1.5,
      'category': 'Vegetable',
      'default_unit': 'cup',
      'default_quantity': 90,
    },
    {
      'name': 'Carrot',
      'calories_per_100g': 41,
      'protein_per_100g': 0.9,
      'carbs_per_100g': 10,
      'fat_per_100g': 0.2,
      'sugar_per_100g': 4.7,
      'category': 'Vegetable',
      'default_unit': 'piece',
      'default_quantity': 60,
    },
    {
      'name': 'Spinach',
      'calories_per_100g': 23,
      'protein_per_100g': 2.9,
      'carbs_per_100g': 3.6,
      'fat_per_100g': 0.4,
      'sugar_per_100g': 0.4,
      'category': 'Vegetable',
      'default_unit': 'cup',
      'default_quantity': 30,
    },

    // Proteins
    {
      'name': 'Chicken Breast',
      'calories_per_100g': 165,
      'protein_per_100g': 31,
      'carbs_per_100g': 0,
      'fat_per_100g': 3.6,
      'sugar_per_100g': 0,
      'category': 'Protein',
      'default_unit': 'g',
      'default_quantity': 100,
    },
    {
      'name': 'Salmon',
      'calories_per_100g': 208,
      'protein_per_100g': 25,
      'carbs_per_100g': 0,
      'fat_per_100g': 12,
      'sugar_per_100g': 0,
      'category': 'Protein',
      'default_unit': 'g',
      'default_quantity': 100,
    },
    {
      'name': 'Eggs',
      'calories_per_100g': 155,
      'protein_per_100g': 13,
      'carbs_per_100g': 1.1,
      'fat_per_100g': 11,
      'sugar_per_100g': 1.1,
      'category': 'Protein',
      'default_unit': 'piece',
      'default_quantity': 50,
    },

    // Grains
    {
      'name': 'Brown Rice',
      'calories_per_100g': 111,
      'protein_per_100g': 2.6,
      'carbs_per_100g': 23,
      'fat_per_100g': 0.9,
      'sugar_per_100g': 0.4,
      'category': 'Grain',
      'default_unit': 'cup',
      'default_quantity': 200,
    },
    {
      'name': 'White Rice',
      'calories_per_100g': 130,
      'protein_per_100g': 2.7,
      'carbs_per_100g': 28,
      'fat_per_100g': 0.3,
      'sugar_per_100g': 0.1,
      'category': 'Grain',
      'default_unit': 'cup',
      'default_quantity': 200,
    },
    {
      'name': 'Oatmeal',
      'calories_per_100g': 68,
      'protein_per_100g': 2.4,
      'carbs_per_100g': 12,
      'fat_per_100g': 1.4,
      'sugar_per_100g': 0.2,
      'category': 'Grain',
      'default_unit': 'cup',
      'default_quantity': 80,
    },

    // Dairy
    {
      'name': 'Milk (Whole)',
      'calories_per_100g': 61,
      'protein_per_100g': 3.2,
      'carbs_per_100g': 4.8,
      'fat_per_100g': 3.3,
      'sugar_per_100g': 4.8,
      'category': 'Dairy',
      'default_unit': 'cup',
      'default_quantity': 240,
    },
    {
      'name': 'Greek Yogurt',
      'calories_per_100g': 59,
      'protein_per_100g': 10,
      'carbs_per_100g': 3.6,
      'fat_per_100g': 0.4,
      'sugar_per_100g': 3.6,
      'category': 'Dairy',
      'default_unit': 'cup',
      'default_quantity': 170,
    },
    {
      'name': 'Cheese (Cheddar)',
      'calories_per_100g': 403,
      'protein_per_100g': 25,
      'carbs_per_100g': 1.3,
      'fat_per_100g': 33,
      'sugar_per_100g': 0.5,
      'category': 'Dairy',
      'default_unit': 'slice',
      'default_quantity': 28,
    },

    // Snacks & Sweets
    {
      'name': 'Chocolate Bar',
      'calories_per_100g': 546,
      'protein_per_100g': 7.3,
      'carbs_per_100g': 59,
      'fat_per_100g': 31,
      'sugar_per_100g': 47.9,
      'category': 'Snack',
      'default_unit': 'bar',
      'default_quantity': 45,
    },
    {
      'name': 'Coca Cola',
      'calories_per_100g': 42,
      'protein_per_100g': 0,
      'carbs_per_100g': 10.6,
      'fat_per_100g': 0,
      'sugar_per_100g': 10.6,
      'category': 'Beverage',
      'default_unit': 'can',
      'default_quantity': 355,
    },
    {
      'name': 'Orange Juice',
      'calories_per_100g': 45,
      'protein_per_100g': 0.7,
      'carbs_per_100g': 10.4,
      'fat_per_100g': 0.2,
      'sugar_per_100g': 8.4,
      'category': 'Beverage',
      'default_unit': 'cup',
      'default_quantity': 240,
    },
  ];

  // Search for foods by name
  static List<Map<String, dynamic>> searchFoods(String query) {
    if (query.isEmpty) return _foods;
    
    final lowercaseQuery = query.toLowerCase();
    return _foods.where((food) {
      return food['name'].toLowerCase().contains(lowercaseQuery) ||
             food['category'].toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Get all foods
  static List<Map<String, dynamic>> getAllFoods() {
    return _foods;
  }

  // Get foods by category
  static List<Map<String, dynamic>> getFoodsByCategory(String category) {
    return _foods.where((food) => 
      food['category'].toLowerCase() == category.toLowerCase()
    ).toList();
  }

  // Get all categories
  static List<String> getCategories() {
    return _foods.map((food) => food['category'] as String).toSet().toList();
  }

  // Create a FoodEntry from database food and quantity
  static FoodEntry createFoodEntry({
    required Map<String, dynamic> food,
    required double quantity,
    String? unit,
    String? brand,
  }) {
    final actualQuantity = quantity;
    final actualUnit = unit ?? food['default_unit'] as String;
    
    // Calculate nutritional values based on quantity
    final calories = ((food['calories_per_100g'] as int) * actualQuantity / 100).round();
    final protein = (food['protein_per_100g'] as double) * actualQuantity / 100;
    final carbs = (food['carbs_per_100g'] as double) * actualQuantity / 100;
    final fat = (food['fat_per_100g'] as double) * actualQuantity / 100;
    final sugar = (food['sugar_per_100g'] as double) * actualQuantity / 100;

    return FoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: food['name'] as String,
      quantity: actualQuantity,
      unit: actualUnit,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      sugar: sugar,
      timestamp: DateTime.now(),
      brand: brand,
      category: food['category'] as String,
    );
  }

  // Get nutritional info for a food item
  static Map<String, dynamic>? getFoodInfo(String foodName) {
    try {
      return _foods.firstWhere((food) => 
        food['name'].toLowerCase() == foodName.toLowerCase()
      );
    } catch (e) {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';
import '../models/food_entry.dart';
import '../models/food_database.dart';

class FoodLoggingScreen extends StatefulWidget {
  const FoodLoggingScreen({super.key});

  @override
  State<FoodLoggingScreen> createState() => _FoodLoggingScreenState();
}

class _FoodLoggingScreenState extends State<FoodLoggingScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  
  List<Map<String, dynamic>> _searchResults = [];
  Map<String, dynamic>? _selectedFood;
  String _selectedUnit = 'g';
  double _quantity = 100.0;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchResults = FoodDatabase.getAllFoods();
    _quantityController.text = '100';
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  void _searchFoods(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _searchResults = FoodDatabase.getAllFoods();
      } else {
        _searchResults = FoodDatabase.searchFoods(query);
      }
    });
  }

  void _selectFood(Map<String, dynamic> food) {
    setState(() {
      _selectedFood = food;
      final defaultUnit = food['default_unit'] as String?;
      _selectedUnit = (defaultUnit != null && ['g', 'kg', 'piece', 'cup', 'tbsp', 'tsp', 'ml', 'l'].contains(defaultUnit)) 
          ? defaultUnit 
          : 'g';
      _quantity = (food['default_quantity'] as double? ?? 100.0);
      _quantityController.text = _quantity.toString();
      _searchController.clear();
      _searchResults = FoodDatabase.getAllFoods();
    });
  }

  void _addFoodEntry() {
    if (_selectedFood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a food item first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final healthProvider = Provider.of<HealthProvider>(context, listen: false);
    
    final foodEntry = FoodDatabase.createFoodEntry(
      food: _selectedFood!,
      quantity: _quantity,
      unit: _selectedUnit,
      brand: _brandController.text.isNotEmpty ? _brandController.text : null,
    );

    healthProvider.addFoodEntry(foodEntry);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedFood!['name']} added successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    setState(() {
      _selectedFood = null;
      _quantity = 100.0;
      _quantityController.text = '100';
      _brandController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Food'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<HealthProvider>(
        builder: (context, healthProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Food',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for food items...',
                            prefixIcon: const Icon(Icons.search),
                            border: const OutlineInputBorder(),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      _searchFoods('');
                                    },
                                  )
                                : null,
                          ),
                          onChanged: _searchFoods,
                        ),
                        const SizedBox(height: 12),
                        if (_isSearching)
                          Text(
                            '${_searchResults.length} results found',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Search Results
                if (_searchResults.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isSearching ? 'Search Results' : 'Popular Foods',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final food = _searchResults[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getCategoryColor(food['category']),
                                    child: Text(
                                      food['name'][0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(food['name']),
                                  subtitle: Text(
                                    '${food['category']} • ${food['calories_per_100g']} cal/100g',
                                  ),
                                  trailing: Text(
                                    '${food['sugar_per_100g']}g sugar',
                                    style: TextStyle(
                                      color: _getSugarColor(food['sugar_per_100g']),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onTap: () => _selectFood(food),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Selected Food Details
                if (_selectedFood != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Selected: ${_selectedFood!['name']}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    _selectedFood = null;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Quantity Input
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: _quantityController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _quantity = double.tryParse(value) ?? 100.0;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedUnit.isNotEmpty ? _selectedUnit : 'g',
                                  decoration: const InputDecoration(
                                    labelText: 'Unit',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: 'g', child: Text('g')),
                                    DropdownMenuItem(value: 'kg', child: Text('kg')),
                                    DropdownMenuItem(value: 'piece', child: Text('piece')),
                                    DropdownMenuItem(value: 'cup', child: Text('cup')),
                                    DropdownMenuItem(value: 'tbsp', child: Text('tbsp')),
                                    DropdownMenuItem(value: 'tsp', child: Text('tsp')),
                                    DropdownMenuItem(value: 'ml', child: Text('ml')),
                                    DropdownMenuItem(value: 'l', child: Text('l')),
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedUnit = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Brand Input (Optional)
                          TextField(
                            controller: _brandController,
                            decoration: const InputDecoration(
                              labelText: 'Brand (Optional)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Nutritional Preview
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nutritional Info (per $_quantity $_selectedUnit):',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildNutritionPreview('Calories', _calculateNutrition('calories')),
                                    _buildNutritionPreview('Protein', _calculateNutrition('protein'), 'g'),
                                    _buildNutritionPreview('Carbs', _calculateNutrition('carbs'), 'g'),
                                    _buildNutritionPreview('Fat', _calculateNutrition('fat'), 'g'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildNutritionPreview('Sugar', _calculateNutrition('sugar'), 'g', 
                                        _getSugarColor(_calculateNutrition('sugar'))),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Add Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _addFoodEntry,
                              icon: const Icon(Icons.add),
                              label: const Text('Add to Food Log'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Today's Food Log
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today\'s Food Log',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (healthProvider.foodEntries.isNotEmpty)
                              TextButton.icon(
                                onPressed: () {
                                  _showClearDialog(context, healthProvider);
                                },
                                icon: const Icon(Icons.clear_all),
                                label: const Text('Clear All'),
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        if (healthProvider.foodEntries.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.restaurant_menu,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'No food entries yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Search and add foods to start tracking',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: healthProvider.foodEntries.length,
                            itemBuilder: (context, index) {
                              final entry = healthProvider.foodEntries[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getCategoryColor(entry.category ?? ''),
                                    child: Text(
                                      entry.name[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(entry.name),
                                  subtitle: Text(
                                    '${entry.quantity} ${entry.unit} • ${entry.calories} cal',
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${entry.sugar.toStringAsFixed(1)}g sugar',
                                        style: TextStyle(
                                          color: _getSugarColor(entry.sugar),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _showFoodEntryDetails(context, entry, index, healthProvider);
                                  },
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNutritionPreview(String label, double value, [String unit = '', Color? color]) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(unit == 'g' ? 1 : 0),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(
          '$label$unit',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  double _calculateNutrition(String type) {
    if (_selectedFood == null) return 0.0;
    
    final multiplier = _quantity / 100.0;
    
    switch (type) {
      case 'calories':
        return (_selectedFood!['calories_per_100g'] as int) * multiplier;
      case 'protein':
        return (_selectedFood!['protein_per_100g'] as double) * multiplier;
      case 'carbs':
        return (_selectedFood!['carbs_per_100g'] as double) * multiplier;
      case 'fat':
        return (_selectedFood!['fat_per_100g'] as double) * multiplier;
      case 'sugar':
        return (_selectedFood!['sugar_per_100g'] as double) * multiplier;
      default:
        return 0.0;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'fruit':
        return Colors.green;
      case 'vegetable':
        return Colors.lightGreen;
      case 'protein':
        return Colors.red;
      case 'grain':
        return Colors.amber;
      case 'dairy':
        return Colors.blue;
      case 'snack':
        return Colors.orange;
      case 'beverage':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  Color _getSugarColor(double sugar) {
    if (sugar < 5) return Colors.green;
    if (sugar < 15) return Colors.orange;
    return Colors.red;
  }

  void _showFoodEntryDetails(BuildContext context, FoodEntry entry, int index, HealthProvider healthProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${entry.quantity} ${entry.unit}'),
            Text('Calories: ${entry.calories}'),
            Text('Protein: ${entry.protein.toStringAsFixed(1)}g'),
            Text('Carbs: ${entry.carbs.toStringAsFixed(1)}g'),
            Text('Fat: ${entry.fat.toStringAsFixed(1)}g'),
            Text('Sugar: ${entry.sugar.toStringAsFixed(1)}g'),
            if (entry.brand != null) Text('Brand: ${entry.brand}'),
            Text('Time: ${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              healthProvider.removeFoodEntry(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Food entry removed'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, HealthProvider healthProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Food Entries'),
        content: const Text('Are you sure you want to remove all food entries for today?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              healthProvider.clearFoodEntries();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All food entries cleared'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

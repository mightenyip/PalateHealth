import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';
import 'food_logging_screen.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final healthProvider = Provider.of<HealthProvider>(context, listen: false);
    _caloriesController.text = healthProvider.caloriesConsumed.toString();
    _proteinController.text = healthProvider.protein.toString();
    _carbsController.text = healthProvider.carbs.toString();
    _fatController.text = healthProvider.fat.toString();
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
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
                // Daily Calorie Goal
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daily Calorie Goal',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.orange[200]!),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${healthProvider.caloriesConsumed}',
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                    Text(
                                      'Consumed',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.orange[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green[200]!),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '2000',
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                    Text(
                                      'Goal',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.green[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: healthProvider.caloriesConsumed / 2000,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            healthProvider.caloriesConsumed >= 2000 
                                ? Colors.green 
                                : Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${((healthProvider.caloriesConsumed / 2000) * 100).toStringAsFixed(0)}% of daily goal',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Macronutrients
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Macronutrients',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildMacroCard(
                                context,
                                'Protein',
                                '${healthProvider.protein.toStringAsFixed(1)}g',
                                Colors.red,
                                Icons.fitness_center,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMacroCard(
                                context,
                                'Carbs',
                                '${healthProvider.carbs.toStringAsFixed(1)}g',
                                Colors.blue,
                                Icons.grain,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMacroCard(
                                context,
                                'Fat',
                                '${healthProvider.fat.toStringAsFixed(1)}g',
                                Colors.amber,
                                Icons.opacity,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildMacroCard(
                                context,
                                'Sugar',
                                '${healthProvider.sugar.toStringAsFixed(1)}g',
                                _getSugarColor(healthProvider.sugar),
                                Icons.cake,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.restaurant_menu,
                                      color: Colors.grey[600],
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${healthProvider.foodEntries.length}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Foods',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Add Food Entry
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add Food Entry',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _caloriesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Calories',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.local_fire_department),
                          ),
                          onChanged: (value) {
                            final calories = int.tryParse(value);
                            if (calories != null) {
                              healthProvider.updateCaloriesConsumed(calories);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _proteinController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Protein (g)',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  final protein = double.tryParse(value);
                                  if (protein != null) {
                                    healthProvider.updateProtein(protein);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _carbsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Carbs (g)',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  final carbs = double.tryParse(value);
                                  if (carbs != null) {
                                    healthProvider.updateCarbs(carbs);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _fatController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Fat (g)',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            final fat = double.tryParse(value);
                            if (fat != null) {
                              healthProvider.updateFat(fat);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FoodLoggingScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.search),
                                label: const Text('Search & Add Food'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // Here you could add logic to save the food entry
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Manual entry added successfully!'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Manual Entry'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Quick Add Buttons
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Add',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildQuickAddButton(
                              context,
                              'Apple',
                              '80 cal',
                              () {
                                healthProvider.updateCaloriesConsumed(
                                  healthProvider.caloriesConsumed + 80,
                                );
                                _caloriesController.text = healthProvider.caloriesConsumed.toString();
                              },
                            ),
                            _buildQuickAddButton(
                              context,
                              'Banana',
                              '105 cal',
                              () {
                                healthProvider.updateCaloriesConsumed(
                                  healthProvider.caloriesConsumed + 105,
                                );
                                _caloriesController.text = healthProvider.caloriesConsumed.toString();
                              },
                            ),
                            _buildQuickAddButton(
                              context,
                              'Chicken Breast',
                              '165 cal',
                              () {
                                healthProvider.updateCaloriesConsumed(
                                  healthProvider.caloriesConsumed + 165,
                                );
                                _caloriesController.text = healthProvider.caloriesConsumed.toString();
                              },
                            ),
                            _buildQuickAddButton(
                              context,
                              'Rice (1 cup)',
                              '205 cal',
                              () {
                                healthProvider.updateCaloriesConsumed(
                                  healthProvider.caloriesConsumed + 205,
                                );
                                _caloriesController.text = healthProvider.caloriesConsumed.toString();
                              },
                            ),
                          ],
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
  
  Widget _buildMacroCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickAddButton(
    BuildContext context,
    String food,
    String calories,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              food,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              calories,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getSugarColor(double sugar) {
    if (sugar < 25) return Colors.green;
    if (sugar < 50) return Colors.orange;
    return Colors.red;
  }
}

import 'package:flutter/foundation.dart';
import '../models/food_entry.dart';

class HealthProvider extends ChangeNotifier {
  // Health tracking data
  double _weight = 70.0;
  double _height = 170.0;
  int _steps = 0;
  int _caloriesBurned = 0;
  int _waterIntake = 0; // in ml
  int _sleepHours = 8;
  
  // Nutrition data
  int _caloriesConsumed = 0;
  double _protein = 0.0;
  double _carbs = 0.0;
  double _fat = 0.0;
  double _sugar = 0.0;
  
  // Food logging
  final List<FoodEntry> _foodEntries = [];
  
  // Getters
  double get weight => _weight;
  double get height => _height;
  int get steps => _steps;
  int get caloriesBurned => _caloriesBurned;
  int get waterIntake => _waterIntake;
  int get sleepHours => _sleepHours;
  int get caloriesConsumed => _caloriesConsumed;
  double get protein => _protein;
  double get carbs => _carbs;
  double get fat => _fat;
  double get sugar => _sugar;
  List<FoodEntry> get foodEntries => _foodEntries;
  
  // BMI calculation
  double get bmi => _weight / ((_height / 100) * (_height / 100));
  
  // Health score calculation (0-100)
  int get healthScore {
    int score = 0;
    
    // BMI score (0-30 points)
    if (bmi >= 18.5 && bmi <= 24.9) {
      score += 30;
    } else if (bmi >= 17 && bmi <= 29.9) {
      score += 20;
    } else {
      score += 10;
    }
    
    // Steps score (0-25 points)
    if (_steps >= 10000) {
      score += 25;
    } else if (_steps >= 5000) {
      score += 15;
    } else {
      score += 5;
    }
    
    // Water intake score (0-25 points)
    if (_waterIntake >= 2000) {
      score += 25;
    } else if (_waterIntake >= 1500) {
      score += 15;
    } else {
      score += 5;
    }
    
    // Sleep score (0-20 points)
    if (_sleepHours >= 7 && _sleepHours <= 9) {
      score += 20;
    } else if (_sleepHours >= 6 && _sleepHours <= 10) {
      score += 10;
    } else {
      score += 5;
    }
    
    return score;
  }
  
  // Setters
  void updateWeight(double weight) {
    _weight = weight;
    notifyListeners();
  }
  
  void updateHeight(double height) {
    _height = height;
    notifyListeners();
  }
  
  void updateSteps(int steps) {
    _steps = steps;
    notifyListeners();
  }
  
  void updateCaloriesBurned(int calories) {
    _caloriesBurned = calories;
    notifyListeners();
  }
  
  void updateWaterIntake(int ml) {
    _waterIntake = ml;
    notifyListeners();
  }
  
  void updateSleepHours(int hours) {
    _sleepHours = hours;
    notifyListeners();
  }
  
  void updateCaloriesConsumed(int calories) {
    _caloriesConsumed = calories;
    notifyListeners();
  }
  
  void updateProtein(double protein) {
    _protein = protein;
    notifyListeners();
  }
  
  void updateCarbs(double carbs) {
    _carbs = carbs;
    notifyListeners();
  }
  
  void updateFat(double fat) {
    _fat = fat;
    notifyListeners();
  }
  
  void updateSugar(double sugar) {
    _sugar = sugar;
    notifyListeners();
  }
  
  // Add methods for incrementing values
  void addWaterIntake(int ml) {
    _waterIntake += ml;
    notifyListeners();
  }
  
  void addSteps(int steps) {
    _steps += steps;
    notifyListeners();
  }
  
  // Food entry methods
  void addFoodEntry(FoodEntry foodEntry) {
    _foodEntries.add(foodEntry);
    _caloriesConsumed += foodEntry.calories;
    _protein += foodEntry.protein;
    _carbs += foodEntry.carbs;
    _fat += foodEntry.fat;
    _sugar += foodEntry.sugar;
    notifyListeners();
  }
  
  void removeFoodEntry(int index) {
    if (index >= 0 && index < _foodEntries.length) {
      final foodEntry = _foodEntries[index];
      _caloriesConsumed -= foodEntry.calories;
      _protein -= foodEntry.protein;
      _carbs -= foodEntry.carbs;
      _fat -= foodEntry.fat;
      _sugar -= foodEntry.sugar;
      _foodEntries.removeAt(index);
      notifyListeners();
    }
  }
  
  void clearFoodEntries() {
    _foodEntries.clear();
    _caloriesConsumed = 0;
    _protein = 0.0;
    _carbs = 0.0;
    _fat = 0.0;
    _sugar = 0.0;
    notifyListeners();
  }
}

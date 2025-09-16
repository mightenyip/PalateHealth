class FoodEntry {
  final String id;
  final String name;
  final double quantity; // in grams or pieces
  final String unit; // g, piece, cup, etc.
  final int calories;
  final double protein; // in grams
  final double carbs; // in grams
  final double fat; // in grams
  final double sugar; // in grams
  final DateTime timestamp;
  final String? brand;
  final String? category; // fruit, vegetable, meat, etc.

  FoodEntry({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    required this.timestamp,
    this.brand,
    this.category,
  });

  // Factory constructor for creating from database
  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    return FoodEntry(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      unit: json['unit'] ?? 'g',
      calories: json['calories'] ?? 0,
      protein: (json['protein'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      sugar: (json['sugar'] ?? 0).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      brand: json['brand'],
      category: json['category'],
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'sugar': sugar,
      'timestamp': timestamp.toIso8601String(),
      'brand': brand,
      'category': category,
    };
  }

  // Create a copy with updated values
  FoodEntry copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? sugar,
    DateTime? timestamp,
    String? brand,
    String? category,
  }) {
    return FoodEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      sugar: sugar ?? this.sugar,
      timestamp: timestamp ?? this.timestamp,
      brand: brand ?? this.brand,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'FoodEntry(name: $name, quantity: $quantity $unit, calories: $calories)';
  }
}

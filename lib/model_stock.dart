// models/stock_model.dart
class StockModel {
  int id;
  String name;
  int quantity;
  String unit;

  
  StockModel({required this.id, required this.name, required this.quantity, required this.unit});

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Object? toJson() {
    return null;
  }

  // ignore: missing_return
}

// services/stock_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myfluttercollege/model_stock.dart';

class StockService {
  // Mendapatkan daftar stok dari API
  Future<List<StockModel>> getStockList() async {
    final response = await http.get(Uri.parse('https://example.com/api/stock'));

    if (response.statusCode == 200) {
      List<StockModel> stockList = (jsonDecode(response.body) as List)
          .map((data) => StockModel.fromJson(data))
          .toList();
      return stockList;
    } else {
      throw Exception('Failed to load stock list: ${response.reasonPhrase}');
    }
  }

  // Menambahkan stok baru ke API
  Future<void> addStock(StockModel stock) async {
    final response = await http.post(
      Uri.parse('https://example.com/api/stock'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(stock.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add stock: ${response.reasonPhrase}');
    }
  }

  // Memperbarui stok yang ada di API
  Future<void> updateStock(StockModel stock) async {
    final response = await http.put(
      Uri.parse('https://example.com/api/stock/${stock.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(stock.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update stock: ${response.reasonPhrase}');
    }
  }

  // Menghapus stok dari API
  Future<void> deleteStock(int id) async {
    final response = await http.delete(
      Uri.parse('https://example.com/api/stock/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stock: ${response.reasonPhrase}');
    }
  }
}

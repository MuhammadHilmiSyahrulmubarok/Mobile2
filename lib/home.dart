// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:myfluttercollege/add.dart';
import 'package:myfluttercollege/delete.dart';
import 'package:myfluttercollege/edit.dart';
import 'package:myfluttercollege/model_stock.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StockModel> _stockList = [];
  StockService _stockService = StockService();

  @override
  void initState() {
    super.initState();
    _loadStockList();
  }

  _loadStockList() async {
    _stockList = await _stockService.getStockList();
    setState(() {});
  }

  _addStock() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStockScreen()),
    );
    _loadStockList();
  }

  _editStock(StockModel stock) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditStockScreen(stock: stock)),
    );
    _loadStockList();
  }

  _deleteStock(int id) async {
    await _stockService.deleteStock(id);
    _loadStockList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Management App'),
      ),
      body: _stockList.isEmpty
          ? Center(child: Text('No stock available'))
          : ListView.builder(
              itemCount: _stockList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_stockList[index].name),
                    subtitle: Text(
                        'Quantity: ${_stockList[index].quantity} ${_stockList[index].unit}'),
                    trailing: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editStock(_stockList[index]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteStock(_stockList[index].id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStock,
        tooltip: 'Add Stock',
        child: Icon(Icons.add),
      ),
    );
  }
}

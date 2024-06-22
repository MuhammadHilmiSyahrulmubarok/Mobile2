// screens/add_stock_screen.dart
import 'package:flutter/material.dart';
import 'package:myfluttercollege/delete.dart';
import 'package:myfluttercollege/model_stock.dart';

class AddStockScreen extends StatefulWidget {
  @override
  _AddStockScreenState createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final _formKey = GlobalKey<FormState>();
  StockModel _stock = StockModel;
  StockService _stockService = StockService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock name';
                  }
                  return null;
                },
                onSaved: (value) => _stock.name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _stock.quantity = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Unit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock unit';
                  }
                  return null;
                },
                onSaved: (value) => _stock.unit = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await _stockService.addStock(_stock);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add stock: $e')),
                      );
                    }
                  }
                },
                child: Text('Add Stock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

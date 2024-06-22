import 'package:flutter/material.dart';
import 'package:myfluttercollege/delete.dart';
import 'package:myfluttercollege/model_stock.dart';


class EditStockScreen extends StatefulWidget {
  final StockModel stock;

  EditStockScreen({required this.stock});

  @override
  _EditStockScreenState createState() => _EditStockScreenState();
}

class _EditStockScreenState extends State<EditStockScreen> {
  final _formKey = GlobalKey<FormState>();
  late StockModel _stock;
  StockService _stockService = StockService();

  @override
  void initState() {
    super.initState();
    _stock = widget.stock;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _stock.name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter stock name';
                  }
                  return null;
                },
                onSaved: (value) => _stock.name = value!,
              ),
              TextFormField(
                initialValue: _stock.quantity.toString(),
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
                onSaved: (value) => _stock.quantity = int.parse(value!),
              ),
              TextFormField(
                initialValue: _stock.unit,
                decoration: InputDecoration(labelText: 'Unit'),
                validator: (value) {
                  if (value!.isEmpty) {
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
                    _formKey.currentState?.save();
                    await _stockService.updateStock(_stock);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update Stock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

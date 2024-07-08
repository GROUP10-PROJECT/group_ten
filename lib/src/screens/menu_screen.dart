import 'package:flutter/material.dart';
import 'dart:io';
import '../models/menu_item.dart';
import '../models/menu_servise.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final MenuService _menuService = MenuService();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(_imageFile!, height: 150),
            ElevatedButton(
              onPressed: () async {
                _imageFile = await _menuService.pickImage();
                setState(() {});
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_imageFile != null) {
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  String name = _nameController.text;
                  double price = double.tryParse(_priceController.text) ?? 0.0;

                  MenuItem menuItem =
                      MenuItem(id: id, name: name, price: price);
                  await _menuService.addMenuItem(menuItem, _imageFile!);

                  // Clear the text fields and image after saving
                  _nameController.clear();
                  _priceController.clear();
                  setState(() {
                    late File _imageFile = File('');
                  });
                }
              },
              child: Text('Add Menu Item'),
            ),
          ],
        ),
      ),
    );
  }
}
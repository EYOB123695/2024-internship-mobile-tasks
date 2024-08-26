import 'package:flutter/foundation.dart';

class Product {
  final String imageFilePath;
  final List<String> texts;

  Product({required this.imageFilePath, required this.texts});
}

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  // Product(
  //     imageFilePath: 'assets/images/image.png',
  //     texts: ['Product 1', 'Description 1', '', '']),
  // Product(
  //     imageFilePath: 'assets/images/hat.jpg',
  //     texts: ['Derby Leather Shoes', "120", 'Men\'s shoe', '(4.0)']),
  // Product(
  //     imageFilePath: 'assets/images/bag.jpg',
  //     texts: ['Product 3', 'Description 3', '', '']),

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}

import 'product.dart';

class ProductManager {
  List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print("Product added sucessfully");
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print("There are no products available currently.");
    } else {
      for (var product in _products) {
        product.display();
      }
    }
  }

  void viewSingleProduct(String name) {
    Product? product;
    for (var p in _products) {
      if (p.name == name) {
        product = p;
      }
    }
    if (product != null) {
      product.display();
    } else {
      print("product with the given name is not found");
    }
  }

  void editProduct(String name, String newName, String newdescription,
      double newprice, int newQuantity) {
    Product? product;
    for (var p in _products) {
      if (p.name == name) {
        product = p;
        break;
      }
    }
    if (product != null) {
      product.setName(newName);
      product.setDescription(newdescription);
      product.setPrice(newprice);
      product.setquantity(newQuantity);
    } else {
      print("The product with the givenname is not available");
    }
  }

  void viewPendingProducts() {
    var pendingProducts = _products.where((p) => p.quantity > 0).toList();
    if (pendingProducts.isEmpty) {
      print("There are no pending products.");
    } else {
      print("Pending Products:");
      for (var product in pendingProducts) {
        product.display();
      }
    }
  }

  void viewCompletedProducts() {
    var completedProducts = _products.where((p) => p.quantity <= 0).toList();
    if (completedProducts.isEmpty) {
      print("There are no completed products.");
    } else {
      print("Completed Products:");
      for (var product in completedProducts) {
        product.display();
      }
    }
  }

  void deleteProduct(String name) {
    Product? removedone;
    for (var p in _products) {
      if (p.name == name) {
        removedone = p;
        break;
      }
    }

    if (removedone != null) {
      _products.remove(removedone);
      print("Product is deleted sucessfully");
    } else {
      print("The product with the provided name could not be found ");
    }
  }
}

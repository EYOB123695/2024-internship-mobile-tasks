import 'dart:io';
import '../lib/product_manager.dart';
import '../lib/product.dart';

void main(List<String> arguments) {
  ProductManager productManager = ProductManager();
  bool menu = true;

  while (menu) {
    print("\nWELCOME TO MY ECOMERCE APP");
    print("1. Add a New Product          5. Delete a Product");
    print("2. View All Products          6. View Pending Products");
    print("3. View a Single Product      7. View Completed Products");
    print("4. Edit a Product             8. Exit");
    stdout.write("Please select an option (1-8): ");

    String choice = stdin.readLineSync() ?? "";
    print("");

    switch (choice) {
      case '1':
        stdout.write("Enter product name: ");

        String name = stdin.readLineSync() ?? "";

        stdout.write("Enter product description: ");
        String description = stdin.readLineSync() ?? "";
        stdout.write("Enter product price: ");
        double price = double.tryParse(stdin.readLineSync() ?? '') ?? 0;
        stdout.write("Enter product quantity: ");
        int quantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

        if (price <= 0) {
          print("Invalid price. Must be greater than zero.");
          break;
        }

        Product product = Product(name, description, price, quantity);
        productManager.addProduct(product);
        break;

      case '2':
        productManager.viewAllProducts();
        break;

      case '3':
        stdout.write("Enter product name: ");
        String name = stdin.readLineSync() ?? "";
        productManager.viewSingleProduct(name);
        break;

      case '4':
        stdout.write("Enter product name: ");
        String name = stdin.readLineSync() ?? "";
        stdout.write("Enter new name: ");
        String newName = stdin.readLineSync() ?? "";
        stdout.write("Enter new description: ");
        String newDescription = stdin.readLineSync() ?? "";
        stdout.write("Enter new price: ");
        double newPrice = double.tryParse(stdin.readLineSync() ?? '') ?? 0;
        stdout.write("Enter new quantity: ");
        int newQuantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

        if (newPrice <= 0) {
          print("Invalid price. Must be greater than zero.");
          break;
        }

        productManager.editProduct(
            name, newName, newDescription, newPrice, newQuantity);
        break;

      case '5':
        stdout.write("Enter product name to delete: ");
        String name = stdin.readLineSync() ?? "";
        productManager.deleteProduct(name);
        break;
      case '6':
        productManager.viewPendingProducts();
        break;

      case '7':
        productManager.viewCompletedProducts();
        break;

      case '8':
        menu = false;
        print("Exiting the application. Goodbye!");
        break;

      default:
        print("Invalid choice. Please select a valid option (1-6).");
    }
  }
}

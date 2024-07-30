class Product {
  String _name;
  String _description;
  double _price;
  int _quantity;

  Product(this._name, this._description, this._price, this._quantity) {
    if (_price <= 0) {
      throw ArgumentError("Price must be greater than zero.");
    }
    if (_name.isEmpty) {
      throw ArgumentError("Name cannot be empty.");
    }
    if (_description.isEmpty) {
      throw ArgumentError("Description cannot be empty.");
    }
    if (_quantity < 0) {
      throw ArgumentError("Quantity can not be negative");
    }
  }

  String? get name => _name;
  String? get description => _description;
  double? get price => _price;
  int get quantity => _quantity;

  void setName(String name) {
    if (name.isNotEmpty) {
      _name = name;
    } else {
      print("Name can not be empty!");
    }
  }

  void setDescription(String description) {
    if (description.isNotEmpty) {
      _description = description;
    } else {
      print("Description can not be empty!");
    }
  }

  void setPrice(double price) {
    if (price > 0) {
      _price = price;
    } else {
      print("Enter price that is greater than zero");
    }
  }

  void setquantity(int quantity) {
    if (quantity >= 0) {
      _quantity = quantity;
    } else {
      print("Quantity cannot be negative.");
    }
  }

  void display() {
    print("Name : $_name");
    print("description : $_description");
    print("price : $_price");
    print("Quantity: $_quantity");
  }
}

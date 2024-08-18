class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';
  static String getproductbyid(String id) => '$baseUrl/$id';

  static String deleteproductbyid(String id) => '$baseUrl/$id';

  static String getProducts() => baseUrl;
  static String insertProducts() => baseUrl;
  static String updateProducts() => baseUrl;
}

import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(String id);
  Future<void> deleteProduct(String id);
  Future<void> cacheProduct(ProductModel product);
  Future<void> cacheProducts(List<ProductModel> products);
}

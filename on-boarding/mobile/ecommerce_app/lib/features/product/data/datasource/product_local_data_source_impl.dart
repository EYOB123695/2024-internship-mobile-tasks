import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../model/product_model.dart';
import 'product_local_data_source.dart';

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final productCaheKey = 'PRODUCTS';
  final SharedPreferences _sharedPreferences;
  ProductLocalDataSourceImpl({
    required SharedPreferences sharedpreferences,
  }) : _sharedPreferences = sharedpreferences;

  _getProductCachekey(String id) => '${productCaheKey}_$id';

  @override
  Future<void> cacheProduct(ProductModel product) async {
    await _sharedPreferences.setString(
        _getProductCachekey(product.id), jsonEncode(product.toJson()));
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final Productsjson = _sharedPreferences.getString(productCaheKey);
    if (Productsjson != null) {
      return (jsonDecode(Productsjson) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      throw const CacheException("Product list not found");
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await _sharedPreferences.setString(
      productCaheKey,
      jsonEncode(products.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<void> deleteProduct(String id) {
    return _sharedPreferences.remove(_getProductCachekey(id));
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final Productjson = _sharedPreferences.getString(_getProductCachekey(id));
    if (Productjson != null) {
      return ProductModel.fromJson(jsonDecode(Productjson));
    } else {
      throw const CacheException(
          "could not find product with the given id from cache");
    }
  }
}

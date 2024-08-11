import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_local_data_source_impl.dart';
import 'package:ecommerce_app/features/product/data/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/test_helper.mocks.dart';

// Generate a mock class for SharedPreferences
@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl productLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSource =
        ProductLocalDataSourceImpl(sharedpreferences: mockSharedPreferences);
  });

  const tProductId1 = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  const tProductId2 = 'cccccc-1b1b-4b1b-8b1b-1b1b1b1b1b1b';

  final tProduct1 = ProductModel(
      id: tProductId1,
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageUrl:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png');

  final tProduct2 = ProductModel(
      id: tProductId2,
      name: 'Lenovo Legion 5',
      description: 'Personal computer',
      price: 123.45,
      imageUrl:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png');

  final tProducts = [tProduct1, tProduct2];

  final tProductsJson = jsonEncode(tProducts.map((e) => e.toJson()).toList());
  final tProduct1Json = jsonEncode(tProduct1.toJson());

  group('cacheProduct', () {
    test('should call setString of SharedPreferences', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      await productLocalDataSource.cacheProduct(tProduct1);

      verify(mockSharedPreferences.setString(
        'PRODUCTS_$tProductId1',
        tProduct1Json,
      ));
    });
  });

  group('getProduct', () {
    test('should return ProductModel when cache contains product', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(tProduct1Json);

      final result = await productLocalDataSource.getProduct(tProductId1);

      expect(result, tProduct1);
    });

    test('should throw CacheException when product is not found in cache',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = productLocalDataSource.getProduct;

      expect(() => call(tProductId1),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheProducts', () {
    test('should call setString of SharedPreferences', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      await productLocalDataSource.cacheProducts(tProducts);

      verify(mockSharedPreferences.setString(
        'PRODUCTS',
        tProductsJson,
      ));
    });
  });

  group('getProducts', () {
    test('should return List<ProductModel> when cache contains products',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(tProductsJson);

      final result = await productLocalDataSource.getProducts();

      expect(result, tProducts);
    });

    test('should throw CacheException when products are not found in cache',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = productLocalDataSource.getProducts;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('deleteProduct', () {
    test('should call remove of SharedPreferences', () async {
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      await productLocalDataSource.deleteProduct(tProductId1);

      verify(mockSharedPreferences.remove(
        'PRODUCTS_$tProductId1',
      ));
    });
  });
}

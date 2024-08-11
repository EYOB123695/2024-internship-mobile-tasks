import 'dart:convert';
import 'package:ecommerce_app/features/product/data/model/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/json_reader.dart';

void main() {
  const testProductModel = ProductModel(
      id: 'tId',
      name: 'name',
      description: 'description',
      price: 400,
      imageUrl: 'https://product.image.com/id');

  test('Should be a sub class of Product entity', () async {
    expect(testProductModel, isA<ProductEntity>());
  });
  test('Should return a valid Product entity', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_product_response.json'),
    );
    //act
    final result = ProductModel.fromJson(jsonMap);
    //assert
    expect(result, equals(testProductModel));
  });
  test('Should return a valid json', () async {
    //act
    final result = testProductModel.toJson();
    //arrange
    final expectedjson = {
      'id': 'tId',
      'name': 'name',
      'description': 'description',
      'price': 400,
      'imageUrl': 'https://product.image.com/id'
    };
    //asser
    expect(result, equals(expectedjson));
  });
}

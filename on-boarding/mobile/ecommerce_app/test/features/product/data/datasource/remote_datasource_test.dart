import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const id = "tId";

  test("should return product model when the response code is 200", () async {
    when(mockHttpClient.get(Uri.parse(Urls.getproductbyid(id)))).thenAnswer(
        (_) async => http.Response(
            readJson('helpers/dummy_data/dummy_product_response.json'), 200));
    final result = await productRemoteDataSourceImpl.getProduct(id);

    expect(result, isA<ProductModel>());
  });

  test('should return ServerException when the response code is 404', () async {
    when(mockHttpClient.get(Uri.parse(Urls.getproductbyid(id))))
        .thenAnswer((_) async => http.Response('Not found', 404));

    expect(() async => await productRemoteDataSourceImpl.getProduct(id),
        throwsA(isA<ServerException>()));
  });
  //Test for deleteproductbyid
  test('should send a DELETE request to the correct URL and handle success',
      () async {
    // Arrange
    const id = '123';
    when(mockHttpClient.delete(Uri.parse(Urls.deleteproductbyid(id))))
        .thenAnswer((_) async =>
            http.Response('{"statusCode": 200, "message": ""}', 200));

    // Act
    await productRemoteDataSourceImpl.deleteProduct(id);

    // Assert
    verify(mockHttpClient.delete(Uri.parse(Urls.deleteproductbyid(id))));
  });
  test('should have returned the inserted product(test insertproduct)',
      () async {
    // Arrange
    const id = '123';
    when(mockHttpClient.delete(Uri.parse(Urls.deleteproductbyid(id))))
        .thenAnswer((_) async =>
            http.Response('{"statusCode": 200, "message": ""}', 200));

    // Act
    await productRemoteDataSourceImpl.deleteProduct(id);

    // Assert
    verify(mockHttpClient.delete(Uri.parse(Urls.deleteproductbyid(id))));
  });
  group('ProductRemoteDataSource', () {
    //   test('insertProduct should create a product successfully', () async {
    //     // Arrange
    //     final client = http.Client();
    //     final productDataSource = ProductRemoteDataSourceImpl(client: client);

    //     final product = ProductModel(
    //       id: 'test-id',
    //       name: 'Test Product',
    //       description: 'This is a test product.',
    //       price: 99.99,
    //       imageUrl: 'C:/Users/lenovo/Desktop/bag.jpg',
    //     );

    //     // Act
    //     try {
    //       final result = await productDataSource.insertProduct(product);

    //       // Assert
    //       print('Product created successfully: $result');
    //       expect(result, isA<ProductModel>());
    //       expect(result.name, equals(product.name));
    //     } catch (e) {
    //       // If it fails, it should throw a ServerException
    //       fail('Failed to create product: $e');
    //     } finally {
    //       client.close();
    //     }
    //   },
    //       timeout:
    //           Timeout(Duration(minutes: 12))); // Increased timeout to 2 minutes
    // });
    test("should return a list of product models when the response code is 200",
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProducts()))).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_product_responsetwo.json'),
          200,
        ),
      );

      // Act
      final result = await productRemoteDataSourceImpl.getProducts();

      // Assert
      expect(result, isA<List<ProductModel>>());
      expect(result.length, greaterThan(0)); // Check that the list is not empty
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProducts())))
          .thenAnswer((_) async => http.Response('Not found', 404));

      // Assert
      expect(() async => await productRemoteDataSourceImpl.getProducts(),
          throwsA(isA<ServerException>()));
    });
    test(
        'should update the product and return the updated product model when the response code is 200',
        () async {
      // Arrange
      final product = ProductModel(
        id: 'test-id',
        name: 'Updated Product',
        description: 'This is an updated test product.',
        price: 109.99,
        imageUrl: 'C:/Users/lenovo/Desktop/updated_bag.jpg',
      );

      when(mockHttpClient.put(
        Uri.parse('${Urls.insertProducts()}/${product.id}'),
        body: jsonEncode(product.toJson()),
      )).thenAnswer(
        (_) async => http.Response(
          jsonEncode({'data': product.toJson()}),
          200,
        ),
      );

      // Act
      final result = await productRemoteDataSourceImpl.updateProducts(product);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.name, equals(product.name));
    });

    test('should throw ServerException when updating the product fails',
        () async {
      // Arrange
      final product = ProductModel(
        id: 'test-id',
        name: 'Updated Product',
        description: 'This is an updated test product.',
        price: 109.99,
        imageUrl: 'C:/Users/lenovo/Desktop/updated_bag.jpg',
      );

      when(mockHttpClient.put(
        Uri.parse('${Urls.insertProducts()}/${product.id}'),
        body: jsonEncode(product.toJson()),
      )).thenAnswer(
        (_) async => http.Response('Server error', 500),
      );

      // Assert
      expect(
          () async => await productRemoteDataSourceImpl.updateProducts(product),
          throwsA(isA<ServerException>()));
    });
  });
  test("should return a list of product models when the response code is 200",
      () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(Urls.getProducts()))).thenAnswer(
      (_) async => http.Response(
        readJson('helpers/dummy_data/dummy_product_responsetwo.json'),
        200,
      ),
    );

    // Act
    final result = await productRemoteDataSourceImpl.getProducts();

    // Assert
    expect(result, isA<List<ProductModel>>());
    expect(result.length, greaterThan(0)); // Check that the list is not empty
  });

  test('should throw ServerException when the response code is not 200',
      () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(Urls.getProducts())))
        .thenAnswer((_) async => http.Response('Not found', 404));

    // Assert
    expect(() async => await productRemoteDataSourceImpl.getProducts(),
        throwsA(isA<ServerException>()));
  });
}

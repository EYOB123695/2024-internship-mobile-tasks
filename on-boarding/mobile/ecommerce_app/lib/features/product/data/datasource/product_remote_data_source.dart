import 'dart:convert';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:http_parser/http_parser.dart';

import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProduct(String id);
  Future<void> deleteProduct(String id);
  Future<ProductModel> insertProduct(ProductModel product);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> updateProducts(ProductModel product);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.getproductbyid(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('failed');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.getproductbyid(id)));
    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException('failed');
    }
  }

  Future<ProductModel> insertProduct(ProductModel product) async {
    try {
      final uri = Uri.parse(Urls.insertProducts());
      final request = http.MultipartRequest("POST", uri);
      request.fields.addAll({
        'name': product.name,
        'description': product.description,
        'price': product.price.toString()
      });
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        product.imageUrl,
        contentType: MediaType('image', 'jpeg'),
      ));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        final result = await response.stream.bytesToString();
        return ProductModel.fromJson(jsonDecode(result)['data']);
      } else {
        throw ServerException(
            response.reasonPhrase ?? "Error occured while uplaoding");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(Uri.parse(Urls.getProducts()));

      if (response.statusCode == 200) {
        // Assuming the list of products is under the 'data' key
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        final List<ProductModel> products =
            data.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();

        return products;
      } else {
        throw ServerException(
            'Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw ServerException('An error occurred: $e');
    }
  }

  @override
  Future<ProductModel> updateProducts(ProductModel product) async {
    try {
      final uri = Uri.parse(Urls.updateProducts() + '/${product.id}');
      print("getting into remote");
      // Create a multipart request
      final response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      print(response.body);

      // Check the response
      if (response.statusCode == 200) {
        print("if");
        var jsonData = json.decode(response.body);
        var productData = jsonData['data'];
        var x = ProductModel.fromJson(productData);
        print('x $x');
        return x;
      } else {
        print("else");
        throw ServerException(
            response.reasonPhrase ?? "Error occurred while updating");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getproduct(String id);
  Future<Either<Failure, Unit>> deleteproduct(String id);

  Future<Either<Failure, ProductEntity>> insertProduct(ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getproducts();

  Future<Either<Failure, ProductEntity>> updateproducts(ProductEntity product);
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../core/constants/network/network_info.dart';
import '../datasource/product_local_data_source.dart';
import '../datasource/product_local_data_source_impl.dart';
import '../model/product_mapper.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;
  final ProductLocalDataSource _productLocalDataSource;
  final NetworkInfo _networkInfo;

  ProductRepositoryImpl(
    this._networkInfo,
    this._productRemoteDataSource,
    this._productLocalDataSource,
  );

  @override
  Future<Either<Failure, ProductEntity>> getproduct(String id) async {
    if (await _networkInfo.isConnected) {
      // Network is available, fetch from remote data source
      try {
        final result = await _productRemoteDataSource.getProduct(id);
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure("An error has occurred"));
      } on SocketException {
        return const Left(
            ConnectionFailure("Failed to connect to the network"));
      }
    } else {
      // No network, fetch from local data source
      try {
        final result = await _productLocalDataSource.getProduct(id);
        return Right(result.toEntity());
      } on CacheException {
        return const Left(CacheFailure("No cached data available"));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteproduct(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        await _productLocalDataSource.deleteProduct(id);
        await _productRemoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure("Failed to connect"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getproducts() async {
    if (await _networkInfo.isConnected) {
      try {
        final products = await _productRemoteDataSource.getProducts();
        await _productLocalDataSource.cacheProducts(products);
        return Right(products as List<ProductModel>);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final products =
            await _productLocalDataSource.getProducts(); // Await the future
        return Right(products);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> insertProduct(
      ProductEntity product) async {
    final productModel = product.toModel();
    if (await _networkInfo.isConnected) {
      try {
        await _productRemoteDataSource.insertProduct(productModel);
        _productLocalDataSource.cacheProduct(productModel);
        return Right(productModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure("failed to connect"));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateproducts(
      ProductEntity product) async {
    final productModel = product.toModel();
    if (await _networkInfo.isConnected) {
      try {
        await _productRemoteDataSource.updateProducts(productModel);
        _productLocalDataSource.cacheProduct(productModel);
        return Right(product);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure("No connection"));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/data/model/product_model.dart';
import 'package:ecommerce_app/features/product/data/repository/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl productRepositoryImpl;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepositoryImpl = ProductRepositoryImpl(
      mockNetworkInfo,
      mockProductRemoteDataSource,
      mockProductLocalDataSource,
    );
  });

  const testproductmodel = ProductModel(
    id: "tID",
    name: "name",
    description: "description",
    price: 23,
    imageUrl: "imageUrl",
  );

  const testproductentity = ProductEntity(
    id: "tID",
    name: "name",
    description: "description",
    price: 23,
    imageUrl: "imageUrl",
  );

  const id = "tID";

  // Tests for getproduct method
  test(
    "Should return product when network is available and remote data source is successful",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProduct(id))
          .thenAnswer((_) async => testproductmodel);

      // Act
      final result = await productRepositoryImpl.getproduct(id);

      // Assert
      expect(result, equals(Right(testproductmodel.toEntity())));
    },
  );

  test(
    "Should return a server failure when network is available but remote data source fails",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProduct(id))
          .thenThrow(ServerException("failed"));

      // Act
      final result = await productRepositoryImpl.getproduct(id);

      // Assert
      expect(result, equals(Left(ServerFailure("An error has occurred"))));
    },
  );

  test(
    "Should return a connection failure when network is unavailable",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockProductLocalDataSource.getProduct(id))
          .thenAnswer((_) async => testproductmodel);

      // Act
      final result = await productRepositoryImpl.getproduct(id);

      // Assert
      expect(result, equals(Right(testproductmodel.toEntity())));
    },
  );

  test(
    "Should return a cache failure when network is unavailable and local data source fails",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockProductLocalDataSource.getProduct(id))
          .thenThrow(CacheException("No cached data available"));

      // Act
      final result = await productRepositoryImpl.getproduct(id);

      // Assert
      expect(
          result, equals(const Left(CacheFailure("No cached data available"))));
    },
  );

  // Tests for deleteproduct method
  test(
    "Should return Unit when network is available and both remote and local data source delete successfully",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.deleteProduct(id))
          .thenAnswer((_) async => {});
      when(mockProductLocalDataSource.deleteProduct(id))
          .thenAnswer((_) async => {});

      // Act
      final result = await productRepositoryImpl.deleteproduct(id);

      // Assert
      expect(result, equals(const Right(unit)));
    },
  );

  test(
    "Should return a server failure when network is available but remote data source fails",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.deleteProduct(id))
          .thenThrow(ServerException("failed"));

      // Act
      final result = await productRepositoryImpl.deleteproduct(id);

      // Assert
      expect(result, equals(Left(ServerFailure("failed"))));
    },
  );

  test(
    "Should return a connection failure when network is unavailable",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await productRepositoryImpl.deleteproduct(id);

      // Assert
      expect(
          result, equals(const Left(ConnectionFailure("Failed to connect"))));
    },
  );

  // Tests for insertProduct method
  test(
    "Should return a ServerFailure when the remote data source fails",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.insertProduct(testproductmodel))
          .thenThrow(ServerException("failed"));

      // Act
      final result =
          await productRepositoryImpl.insertProduct(testproductentity);

      // Assert
      expect(result, equals(Left(ServerFailure("failed"))));
    },
  );

  test(
    "Should return a ConnectionFailure when there is no network connection",
    () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result =
          await productRepositoryImpl.insertProduct(testproductentity);

      // Assert
      expect(
          result, equals(const Left(ConnectionFailure("failed to connect"))));
    },
  );
}

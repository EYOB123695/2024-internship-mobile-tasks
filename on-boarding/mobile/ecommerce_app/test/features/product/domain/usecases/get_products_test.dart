import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository mockProductRepository;
  late GetProductsUseCase getProductsUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductsUseCase = GetProductsUseCase(mockProductRepository);
  });

  final tProduct1 = ProductEntity(
      id: 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b',
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageUrl:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png');

  final tProduct2 = ProductEntity(
      id: 'cccccc-1b1b-4b1b-8b1b-1b1b1b1b1b1b',
      name: 'Lenovo Legion 5',
      description: 'Personal computer',
      price: 123.45,
      imageUrl:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png');

  final tProducts = [tProduct1, tProduct2];

  group('execute', () {
    test(
        'should return a list of ProductEntity when the repository call is successful',
        () async {
      // Arrange
      when(mockProductRepository.getproducts())
          .thenAnswer((_) async => Right(tProducts));

      // Act
      final result = await getProductsUseCase.execute();

      // Assert
      expect(result, Right(tProducts));
      verify(mockProductRepository.getproducts());
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a Failure when the repository call is unsuccessful',
        () async {
      // Arrange
      final tFailure =
          ServerFailure("Failed"); // Replace with your specific Failure type
      when(mockProductRepository.getproducts())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await getProductsUseCase.execute();

      // Assert
      expect(result, Left(tFailure));
      verify(mockProductRepository.getproducts());
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
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
  late UpdateProductUseCase updateProductUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProductUseCase = UpdateProductUseCase(mockProductRepository);
  });

  final tProductId = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  final tProduct = ProductEntity(
    id: tProductId,
    name: 'HP Victus 15',
    description: 'Personal computer',
    price: 123.45,
    imageUrl:
        'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
  );

  group('execute', () {
    test(
        'should return updated ProductEntity when the repository call is successful',
        () async {
      // Arrange
      when(mockProductRepository.updateproducts(tProduct))
          .thenAnswer((_) async => Right(tProduct));

      // Act
      final result = await updateProductUseCase.execute(tProductId, tProduct);

      // Assert
      expect(result, Right(tProduct));
      verify(mockProductRepository.updateproducts(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a Failure when the repository call is unsuccessful',
        () async {
      // Arrange
      final tFailure =
          ServerFailure("Failed"); // Replace with your specific Failure type
      when(mockProductRepository.updateproducts(tProduct))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await updateProductUseCase.execute(tProductId, tProduct);

      // Assert
      expect(result, Left(tFailure));
      verify(mockProductRepository.updateproducts(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}

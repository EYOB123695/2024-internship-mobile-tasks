import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/deleteproduct.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository);
  });

  const tProductId = 'id';

  test('should return unit when deleteproduct is successful', () async {
    // Arrange
    when(mockProductRepository.deleteproduct(tProductId))
        .thenAnswer((_) async => const Right(unit)); // Use `unit` for success

    // Act
    final result = await deleteProductUseCase.execute(tProductId);

    // Assert
    expect(result, equals(const Right(unit)));
    verify(mockProductRepository.deleteproduct(tProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when deleteproduct fails', () async {
    // Arrange
    when(mockProductRepository.deleteproduct(tProductId)).thenAnswer(
        (_) async => Left(
            ServerFailure('Failed to delete product'))); // Simulate failure

    // Act
    final result = await deleteProductUseCase.execute(tProductId);

    // Assert
    expect(result, equals(Left(ServerFailure('Failed to delete product'))));
    verify(mockProductRepository.deleteproduct(tProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}

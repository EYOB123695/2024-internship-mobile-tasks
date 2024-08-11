import 'package:ecommerce_app/features/product/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late GetProductUseCase getProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProduct = GetProductUseCase(mockProductRepository);
  });

  const tId = 'id';
  const tProduct = ProductEntity(
      id: tId,
      name: 'name',
      description: 'description',
      price: 123.45,
      imageUrl: 'https://product.image.com/id');

  test("should get product entity", () async {
    when(mockProductRepository.getproduct(any))
        .thenAnswer((_) async => const Right(tProduct));

    final result = await getProduct.execute(tId);

    expect(result, const Right(tProduct));
  });
}

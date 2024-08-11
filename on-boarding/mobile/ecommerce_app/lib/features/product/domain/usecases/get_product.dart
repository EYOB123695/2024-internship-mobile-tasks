import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;
  GetProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(String id) {
    return productRepository.getproduct(id);
  }
}

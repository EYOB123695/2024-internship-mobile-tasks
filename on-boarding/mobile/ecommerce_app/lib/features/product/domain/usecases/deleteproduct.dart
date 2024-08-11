import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository productRepository;
  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, Unit>> execute(String id) {
    return productRepository.deleteproduct(id);
  }
}

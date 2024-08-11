import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository productRepository;
  GetProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> execute() {
    return productRepository.getproducts();
  }
}

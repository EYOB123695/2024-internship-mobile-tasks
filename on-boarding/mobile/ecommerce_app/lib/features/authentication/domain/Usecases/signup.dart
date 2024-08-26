import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

import '../entities/UserEntity.dart';
import '../repository/Authrrepository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({required this.authRepository});
  Future<Either<Failure, UserEntity>> execute(
      String name, String email, String password) {
    return authRepository.signUp(name, email, password);
  }
}

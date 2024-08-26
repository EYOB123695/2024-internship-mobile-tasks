import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

import '../repository/Authrrepository.dart';

class LogInUseCase {
  final AuthRepository authRepository;
  const LogInUseCase({required this.authRepository});
  Future<Either<Failure, String>> execute(String email, String password) {
    return authRepository.logIn(email, password);
  }
}

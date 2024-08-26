import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';

import '../repository/Authrrepository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;
  const LogOutUseCase({required this.authRepository});
  Future<Either<Failure, void>> execute() {
    return authRepository.logOut();
  }
}

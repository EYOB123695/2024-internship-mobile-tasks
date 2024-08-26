import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../entities/UserEntity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp(
      String name, String email, String password);
  Future<Either<Failure, String>> logIn(String email, String Password);
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, UserEntity>> getMe();
}

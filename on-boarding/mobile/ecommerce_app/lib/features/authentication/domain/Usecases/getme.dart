import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/UserEntity.dart';
import '../repository/Authrrepository.dart';

class GetMeUseCase {
  AuthRepository authRepository;
  GetMeUseCase({required this.authRepository});
  Future<Either<Failure, UserEntity>> execute() {
    return authRepository.getMe();
  }
}

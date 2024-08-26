import 'package:dartz/dartz.dart';

import '../../../../core/constants/network/network_info.dart';
import '../../../../core/error/failure.dart';
import '../../../product/domain/repository/product_repository.dart';
import '../../domain/entities/UserEntity.dart';
import '../../domain/repository/Authrrepository.dart';
import '../datasource/Authlocaldatasource.dart';
import '../datasource/Authremotedatasource.dart';
import '../model/UserModel.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Authremotedatasource authremotedatasource;
  final Authlocaldatasource authlocaldatasource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl(
      {required this.authremotedatasource,
      required this.authlocaldatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> signUp(
      String name, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await authremotedatasource.signUp(name, email, password);
        print('SignUp Success: $user'); // Debugging line
        await authlocaldatasource.cacheUser(user);
        print('User Cached Successfully'); // Debugging line
        return Right(user.toEntity());
      } catch (e) {
        print('SignUp or Cache Failure: $e'); // Logging any exceptions
        return Left(
            ServerFailure("Server")); // Replace with appropriate error handling
      }
    } else {
      print('No Internet Connection');
      return Left(NetworkFailure(
          "Failed")); // Return appropriate failure if no connection
    }
  }

  @override
  Future<Either<Failure, String>> logIn(String email, String Password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authremotedatasource.logIn(email, Password);
        await authlocaldatasource.cacheToken(token);
        return Right(token);
      } catch (e) {
        return Left(ServerFailure("Failed to connect to Server"));
      }
    } else {
      return Left(NetworkFailure("Failed to connect to the internet"));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await authlocaldatasource.clearCache();
      await authlocaldatasource.clearToken();
      if (await networkInfo.isConnected) {
        await authremotedatasource.logOut();
      }
      return Right(null);
    } catch (e) {
      return Left(ServerFailure("Server Failure occured"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await authremotedatasource.getMe();
        await authlocaldatasource.cacheUser(user); // Update local cache
        return Right(user);
      } catch (e) {
        return Left(ServerFailure("Server Failure Ocuured"));
      }
    } else {
      try {
        final cachedUser = await authlocaldatasource.getCachedUser();
        return Right(cachedUser);
      } catch (e) {
        return Left(CacheFailure("Failed to cache"));
      }
    }
  }
}

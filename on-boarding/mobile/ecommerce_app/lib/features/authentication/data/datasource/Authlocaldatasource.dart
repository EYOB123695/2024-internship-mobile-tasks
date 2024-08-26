import '../../domain/entities/UserEntity.dart';

abstract class Authlocaldatasource {
  Future<void> cacheUser(UserEntity user);
  Future<UserEntity> getCachedUser();
  Future<String> getCachedToken();
  Future<void> cacheToken(String token);
  Future<void> clearToken();
  Future<void> clearCache();
}

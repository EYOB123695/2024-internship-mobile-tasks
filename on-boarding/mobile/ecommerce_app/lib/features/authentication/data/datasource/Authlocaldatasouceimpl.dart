import 'dart:convert'; // For encoding and decoding JSON
import 'package:ecommerce_app/features/authentication/data/datasource/Authlocaldatasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exception.dart';

import '../../domain/entities/UserEntity.dart';

import '../model/UserModel.dart'; // Assuming UserModel is your model with JSON methods

class AuthLocalDataSourceImpl implements Authlocaldatasource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserEntity user) async {
    try {
      final userModel = UserModel(
        username: user.username,
        password: user.password,
        email: user.email,
      );
      final userJson = json.encode(userModel.toJson());
      await sharedPreferences.setString('cached_user', userJson);
    } catch (e) {
      throw CacheException(
          "Cache exception"); // Custom exception for cache errors
    }
  }

  @override
  Future<UserEntity> getCachedUser() async {
    try {
      final userJson = sharedPreferences.getString('cached_user');
      if (userJson != null) {
        final Map<String, dynamic> userMap = json.decode(userJson);
        return UserModel.fromJson(userMap);
      } else {
        throw CacheException("Cache exception"); // No cached user found
      }
    } catch (e) {
      throw CacheException("Cache exception"); // Handle JSON decoding errors
    }
  }

  @override
  Future<String> getCachedToken() async {
    try {
      final token = sharedPreferences.getString('cached_token');
      if (token != null) {
        return token;
      } else {
        throw CacheException("Cache exception"); // No cached token found
      }
    } catch (e) {
      throw CacheException("Cache exception"); // Handle errors
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    try {
      await sharedPreferences.setString('cached_token', token);
    } catch (e) {
      throw CacheException(
          "Cache exception"); // Custom exception for cache errors
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await sharedPreferences.remove('cached_token');
    } catch (e) {
      throw CacheException(
          "Cache exception occured"); // Custom exception for cache errors
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove('cached_user');
      await sharedPreferences.remove('cached_token');
    } catch (e) {
      throw CacheException(
          "Cache exception occured"); // Custom exception for cache errors
    }
  }
}

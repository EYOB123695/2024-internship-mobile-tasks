import 'dart:convert';
import 'package:ecommerce_app/features/authentication/data/datasource/Authremotedatasource.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exception.dart';

import '../../domain/entities/UserEntity.dart';

import '../model/UserModel.dart'; // Import the UserModel

class AuthRemoteDataSourceImpl implements Authremotedatasource {
  final http.Client client;
  final String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2'; // Fixed base URL

  AuthRemoteDataSourceImpl({required this.client});
  //  Future<Usermodel> adduser(Usermodel userEntity) async {
  //   final String apiUrl = Urls.adduserurl();
  //   final body = json.encode(userEntity.toJson());

  //   final response = await client.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: body,
  //   );

  //   if (response.statusCode == 201) {
  //     final data = json.decode(response.body);
  //     return Usermodel.fromJson(data);
  //   } else {
  //     final data = json.decode(response.body);
  //     throw Exception(data['message'] ?? 'Failed to register user');
  //   }
  // }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final String apiUrl = '$baseUrl/auth/register'; // Complete URL for sign-up
    final body = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Failed to sign up');
    }
  }

  @override
  Future<String> logIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login'); // Complete URL for login
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['data']['access_token'];
    } else {
      throw ServerException("Server exception occurred");
    }
  }

  @override
  Future<void> logOut() async {
    final url = Uri.parse('$baseUrl/auth/logout'); // Complete URL for logout
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException("Server exception occurred");
    }
  }

  @override
  Future<UserEntity> getMe() async {
    final url =
        Uri.parse('$baseUrl/users/me'); // Complete URL for fetching user data
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(
          data['data']); // Use UserModel for JSON deserialization
    } else {
      throw ServerException("Server exception occurred");
    }
  }
}

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  // final String id;
  final String username;
  final String password;
  final String email;
  UserEntity(
      { //required this.id,
      required this.username,
      required this.password,
      required this.email});
  @override
  List<Object> get props => [username, password, email];
}

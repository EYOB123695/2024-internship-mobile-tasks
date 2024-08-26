import '../../domain/entities/UserEntity.dart';
import '../model/UserModel.dart';

abstract class Authremotedatasource {
  Future<UserModel> signUp(String name, String email, String password);
  Future<String> logIn(String email, String Password);
  Future<void> logOut();
  Future<UserEntity> getMe();
}

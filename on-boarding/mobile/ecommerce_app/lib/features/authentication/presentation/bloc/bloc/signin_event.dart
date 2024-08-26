part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninButtonPressed extends SigninEvent {
  final String password;
  final String email;
  SigninButtonPressed({required this.password, required this.email});
  List<Object> get props => [email, password];
}

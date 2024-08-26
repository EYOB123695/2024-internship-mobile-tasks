part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess({required this.message});
  List<Object> get props => [message];
}

class SignupFailure extends SignupState {
  final String error;
  SignupFailure({required this.error});
  List<Object> get props => [error];
}

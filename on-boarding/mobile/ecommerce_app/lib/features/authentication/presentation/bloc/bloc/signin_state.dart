part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  final String message;
  SigninSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class SigninFailure extends SigninState {
  final String error;
  SigninFailure({required this.error});

  @override
  List<Object> get props => [error];
}

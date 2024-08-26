import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/Usecases/Login.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final LogInUseCase logInUseCase;
  SigninBloc({required this.logInUseCase}) : super(SigninInitial()) {
    on<SigninButtonPressed>(_onSigninButtonPressed);
  }
  Future<void> _onSigninButtonPressed(
    SigninButtonPressed event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());
    final Either<Failure, void> result =
        await logInUseCase.execute(event.email, event.password);

    result.fold(
      (failure) => emit(SigninFailure(error: _mapFailureToMessage(failure))),
      (_) => emit(SigninSuccess(message: "Login successful")),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else {
      return 'Unexpected error occurred. Please try again.';
    }
  }
}

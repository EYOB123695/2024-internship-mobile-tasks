import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/Usecases/signup.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUpUseCase;
  SignupBloc({required this.signUpUseCase}) : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSigninButtonPressed);
  }
  Future<void> _onSigninButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());
    final Either<Failure, void> result = await signUpUseCase.execute(
      event.username,
      event.email,
      event.password,
    );

    result.fold(
      (failure) => emit(SignupFailure(error: _mapFailureToMessage(failure))),
      (_) => emit(SignupSuccess(message: "Login successful")),
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

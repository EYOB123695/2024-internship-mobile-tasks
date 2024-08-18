part of 'updateproduct_bloc.dart';

abstract class UpdateproductState extends Equatable {
  const UpdateproductState();

  @override
  List<Object> get props => [];
}

class UpdateproductInitial extends UpdateproductState {}

class UpdateproductLoading extends UpdateproductState {}

class UpdateproductSucess extends UpdateproductState {
  final String message;
  UpdateproductSucess({required this.message});
}

class UpdateproductFailure extends UpdateproductState {
  final String error;
  UpdateproductFailure({required this.error});
}

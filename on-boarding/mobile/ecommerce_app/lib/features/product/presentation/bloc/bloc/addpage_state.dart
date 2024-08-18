part of 'addpage_bloc.dart';

abstract class AddproductState extends Equatable {
  const AddproductState();

  @override
  List<Object> get props => [];
}

class AddpageInitial extends AddproductState {}

class AddProductLoading extends AddproductState {}

class AddProductSucess extends AddproductState {}

class AddProductFailure extends AddproductState {
  final String error;
  const AddProductFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class DeleteProductSucess extends AddproductState {}

class DeleteProductFailure extends AddproductState {
  final String error;
  const DeleteProductFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class DeleteProductLoading extends AddproductState {}

part of 'detailpage_bloc.dart';

abstract class DetailpageState extends Equatable {
  const DetailpageState();

  @override
  List<Object> get props => [];
}

class DetailpageInitial extends DetailpageState {}

class DetailsInitial extends DetailpageState {}

class DetailsLoading extends DetailpageState {}

class DeleteSucess extends DetailpageState {
  final String message;
  const DeleteSucess({required this.message});
  @override
  List<Object> get props => [message];
}

class DeleteFailure extends DetailpageState {
  final String error;
  const DeleteFailure({required this.error});
  @override
  List<Object> get props => [error];
}

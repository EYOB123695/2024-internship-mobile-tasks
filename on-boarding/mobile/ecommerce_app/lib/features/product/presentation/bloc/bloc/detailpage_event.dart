part of 'detailpage_bloc.dart';

abstract class DetailpageEvent extends Equatable {
  const DetailpageEvent({required String id});

  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends DetailpageEvent {
  final String id;
  DeleteProductEvent({required this.id}) : super(id: id);
  @override
  List<Object> get props => [id];
}

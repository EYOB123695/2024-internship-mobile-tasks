part of 'updateproduct_bloc.dart';

abstract class UpdateproductEvent extends Equatable {
  const UpdateproductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductRequest extends UpdateproductEvent {
  final String id;
  final ProductEntity product;
  UpdateProductRequest({required this.product, required this.id});
  @override
  List<Object> get props => [id, product];
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/insert_product.dart';

part 'addpage_event.dart';
part 'addpage_state.dart';

class AddpageBloc extends Bloc<AddproductEvent, AddproductState> {
  final InsertProductUseCase insertProductUseCase;

  AddpageBloc({required this.insertProductUseCase}) : super(AddpageInitial()) {
    on<Addproduct>(_onAddProduct);
  }

  Future<void> _onAddProduct(
    Addproduct event,
    Emitter<AddproductState> emit,
  ) async {
    emit(AddProductLoading());
    try {
      final product = ProductEntity(
          id: "00",
          name: event.name,
          description: event.Category,
          price: event.price,
          imageUrl: event.imageUrl);
      Either<Failure, ProductEntity> result =
          await insertProductUseCase.execute(product);
      result.fold(
        (failure) => emit(AddProductFailure(error: "Failed")),
        (product) => emit(AddProductSucess()),
      );
    } catch (e) {
      emit(AddProductFailure(error: e.toString()));
    }
  }
}

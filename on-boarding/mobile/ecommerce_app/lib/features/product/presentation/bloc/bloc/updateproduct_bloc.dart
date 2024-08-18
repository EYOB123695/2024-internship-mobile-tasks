import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/update_product.dart';

part 'updateproduct_event.dart';
part 'updateproduct_state.dart';

class UpdateproductBloc extends Bloc<UpdateproductEvent, UpdateproductState> {
  final UpdateProductUseCase updateProductUseCase;
  UpdateproductBloc({required this.updateProductUseCase})
      : super(UpdateproductInitial()) {
    on<UpdateProductRequest>(_onUpdatePageLoad);
  }

  Future<void> _onUpdatePageLoad(
    UpdateProductRequest event,
    Emitter<UpdateproductState> emit,
  ) async {
    print("update event");
    emit(UpdateproductLoading());
    try {
      final Either<Failure, ProductEntity> result =
          await updateProductUseCase.execute(event.id, event.product);
      emit(result.fold(
        (failure) => UpdateproductFailure(error: _mapFailureToMessage(failure)),
        (product) =>
            UpdateproductSucess(message: 'Product updated successfully'),
      ));
    } catch (_) {
      emit(UpdateproductFailure(error: 'Failed to load products'));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Return more specific messages based on the Failure type
    return "Failed to load products";
  }
}

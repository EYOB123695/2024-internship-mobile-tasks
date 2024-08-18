import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import '../../../domain/usecases/deleteproduct.dart';

part 'detailpage_event.dart';
part 'detailpage_state.dart';

class DetailpageBloc extends Bloc<DetailpageEvent, DetailpageState> {
  final DeleteProductUseCase deleteProductUseCase;

  DetailpageBloc({required this.deleteProductUseCase})
      : super(DetailpageInitial()) {
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<DetailpageState> emit,
  ) async {
    emit(DetailsLoading());

    final Either<Failure, Unit> result =
        await deleteProductUseCase.execute(event.id);

    result.fold(
      (failure) => emit(DeleteFailure(error: _mapFailureToMessage(failure))),
      (_) => emit(DeleteSucess(message: "Product deleted successfully")),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map failure to a user-friendly error message
    // You can customize this to provide more specific messages based on the failure
    return "An error occurred while deleting the product.";
  }
}

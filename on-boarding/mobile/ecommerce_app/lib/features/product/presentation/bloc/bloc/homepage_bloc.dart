import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_products.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetProductsUseCase getProductsUseCase;

  HomepageBloc({required this.getProductsUseCase}) : super(HomepageInitial()) {
    on<HomePageLoadEvent>(_onHomePageLoad);
    on<RefreshPageLoadEvent>(_onRefreshPageLoad);
  }

  Future<void> _onHomePageLoad(
    HomePageLoadEvent event,
    Emitter<HomepageState> emit,
  ) async {
    emit(HomePageLoading());
    try {
      final Either<Failure, List<ProductEntity>> result =
          await getProductsUseCase.execute();
      emit(result.fold(
        (failure) => HomePageError(Message: _mapFailureToMessage(failure)),
        (products) => HomePageLoaded(products: products),
      ));
    } catch (_) {
      emit(HomePageError(Message: 'Failed to load products'));
    }
  }

  Future<void> _onRefreshPageLoad(
    RefreshPageLoadEvent event,
    Emitter<HomepageState> emit,
  ) async {
    emit(HomePageLoading());
    try {
      final Either<Failure, List<ProductEntity>> result =
          await getProductsUseCase.execute();
      emit(result.fold(
        (failure) => HomePageError(Message: _mapFailureToMessage(failure)),
        (products) => HomePageLoaded(products: products),
      ));
    } catch (_) {
      emit(HomePageError(Message: 'Failed to refresh products'));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Return more specific messages based on the Failure type
    return "Failed to load products";
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_product.dart';

part 'searchproduct_event.dart';
part 'searchproduct_state.dart';

class SearchproductBloc extends Bloc<SearchproductEvent, SearchproductState> {
  SearchproductBloc() : super(SearchproductInitial()) {
    on<LoadproductsEvent>(_onLoadProducts);
    on<FilteredProductsEvent>(_onFilteredProducts);
  }
  void _onLoadProducts(
      LoadproductsEvent event, Emitter<SearchproductState> emit) {
    emit(ProductsFilteredState(
      filteredProducts: event.products,
      sliderValue: 50.0,
    ));
  }

  void _onFilteredProducts(
      FilteredProductsEvent event, Emitter<SearchproductState> emit) {
    final filteredProducts = event.products
        .where((product) => product.price <= event.sliderValue)
        .toList();
    emit(ProductsFilteredState(
      filteredProducts: filteredProducts,
      sliderValue: event.sliderValue,
    ));
  }
}

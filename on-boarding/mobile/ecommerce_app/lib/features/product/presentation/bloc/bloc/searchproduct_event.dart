part of 'searchproduct_bloc.dart';

abstract class SearchproductEvent extends Equatable {
  const SearchproductEvent();

  @override
  List<Object> get props => [];
}

class LoadproductsEvent extends SearchproductEvent {
  final List<ProductEntity> products;
  const LoadproductsEvent({required this.products});
  @override
  List<Object> get props => [products];
}

class FilteredProductsEvent extends SearchproductEvent {
  final double sliderValue;
  final List<ProductEntity> products;
  const FilteredProductsEvent(
      {required this.products, required this.sliderValue});
  @override
  List<Object> get props => [products, sliderValue];
}

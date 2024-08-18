part of 'searchproduct_bloc.dart';

abstract class SearchproductState extends Equatable {
  const SearchproductState();

  @override
  List<Object> get props => [];
}

class SearchproductInitial extends SearchproductState {}

class SearchproductLoading extends SearchproductState {}

class SearchproductSucess extends SearchproductState {
  final ProductEntity product;
  const SearchproductSucess(this.product);
  List<Object> get props => [product];
}

class SearchproductFailure extends SearchproductState {
  final String error;
  const SearchproductFailure(this.error);
  List<Object> get props => [error];
}

class ProductsFilteredState extends SearchproductState {
  final List<ProductEntity> filteredProducts;
  final double sliderValue;
  const ProductsFilteredState(
      {required this.filteredProducts, required this.sliderValue});
  List<Object> get props => [filteredProducts, sliderValue];
}

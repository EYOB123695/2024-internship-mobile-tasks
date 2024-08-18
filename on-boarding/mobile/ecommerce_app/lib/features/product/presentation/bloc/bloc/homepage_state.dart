part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomePageLoading extends HomepageState {
  const HomePageLoading();
}

class HomePageLoaded extends HomepageState {
  final List<ProductEntity> products;
  HomePageLoaded({required this.products});
  List<Object> get props => [products];
}

class HomePageRefresh extends HomepageState {
  final List<ProductEntity> products;
  HomePageRefresh({required this.products});
  List<Object> get props => [products];
}

class HomePageError extends HomepageState {
  final String Message;
  HomePageError({required this.Message});
  List<Object> get props => [Message];
}

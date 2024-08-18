part of 'addpage_bloc.dart';

abstract class AddproductEvent extends Equatable {
  const AddproductEvent();

  @override
  List<Object> get props => [];
}

class Addproduct extends AddproductEvent {
  final String name;
  final String Category;
  final double price;
  final String description;
  final String imageUrl;

  Addproduct(
      {required this.name,
      required this.description,
      required this.Category,
      required this.price,
      required this.imageUrl});
  @override
  List<Object> get props => [name, description, Category, price, imageUrl];
}

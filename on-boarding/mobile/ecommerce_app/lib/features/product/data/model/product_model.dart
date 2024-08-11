import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity with EquatableMixin {
  final String? image;
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    this.image,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );

  @override
  List<Object?> get props => [id, name, description, price, imageUrl];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  ProductEntity toEntity() => ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl);
}

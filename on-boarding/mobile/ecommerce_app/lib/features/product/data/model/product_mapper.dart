import '../../domain/entities/product_entity.dart';
import 'product_model.dart';

extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
}

extension ProductEntityMapper on ProductEntity {
  ProductModel toModel() => ProductModel(
        id: id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
}

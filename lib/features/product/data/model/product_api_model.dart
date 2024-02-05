import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

final productApiModelProvider = Provider(
  (ref) => ProductApiModel.empty(),
);

@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: '_id')
  final String? productId;
  final String? productImage;
  final String productName;
  final int price;
  final String category;
  final String desc;

  ProductApiModel({
    this.productId,
    this.productImage,
    required this.productName,
    required this.price,
    required this.category,
    required this.desc,
  });

  ProductApiModel.empty()
      : this(
          productId: '',
          productImage: '',
          productName: '',
          price: 0,
          category: '',
          desc: '',
        );
  ProductEntity toEntity() => ProductEntity(
        productId: productId,
        productImage: productImage,
        productName: productName,
        price: price,
        category: category,
        desc: desc,
      );

  ProductApiModel toApiModel(ProductEntity entity) => ProductApiModel(
        productId: productId ?? '',
        productImage: entity.productImage,
        productName: entity.productName,
        price: entity.price,
        category: entity.category,
        desc: entity.desc,
      );

  List<ProductApiModel> toApiModelList(List<ProductEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

   List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  //From Json
  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  @override
  String toString() {
    return 'productId: $productId, productName: $productName, productImage: $productImage, price: $price, category: $category';
  }
}

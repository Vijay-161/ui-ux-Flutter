import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';

part 'cart_api_model.g.dart';

final cartApiModelProvider = Provider(
  (ref) => CartApiModel.empty(),
);

@JsonSerializable()
class CartApiModel {
  @JsonKey(name: '_id')
  final String? cartId;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'product')
  final String productId;
  final String name;
  final String image;
  final int price;
  final int? quantity;

  CartApiModel({
    this.cartId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.quantity,
  });

  CartApiModel.empty()
      : this(
          cartId: '',
          userId: '',
          productId: '',
          name: '',
          price: 0,
          image: '',
          quantity: null,
        );

  CartEntity toEntity() => CartEntity(
        cartId: cartId,
        userId: userId,
        productId: productId,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
      );

  CartApiModel toApiModel(CartEntity entity) => CartApiModel(
        cartId: cartId ?? '',
        userId: entity.userId,
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        image: entity.image,
        quantity: entity.quantity,
      );

  List<CartApiModel> toApiModelList(List<CartEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<CartEntity> toEntityList(List<CartApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  //From Json
  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  @override
  String toString() {
    return 'cartId: $cartId, userId: $userId, productId: $productId';
  }
}

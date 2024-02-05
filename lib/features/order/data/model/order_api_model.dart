import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/order_entity.dart';

part 'order_api_model.g.dart';

final orderApiModelProvider = Provider(
  (ref) => OrderApiModel.empty(),
);

@JsonSerializable()
class OrderApiModel {
  @JsonKey(name: '_id')
  final String? orderId;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'product')
  final String productId;
  final String name;
  final String image;
  final int price;
  final int? quantity;
  final String username;
  final bool payment;

  OrderApiModel({
    this.orderId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.quantity,
    required this.username,
    required this.payment,
  });

  OrderApiModel.empty()
      : this(
          orderId: '',
          userId: '',
          productId: '',
          name: '',
          price: 0,
          image: '',
          quantity: null,
          username: '',
          payment: false,
        );

  OrderEntity toEntity() => OrderEntity(
        orderId: orderId,
        userId: userId,
        productId: productId,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
        username: username,
        payment: payment
      );

  OrderApiModel toApiModel(OrderEntity entity) => OrderApiModel(
        orderId: orderId ?? '',
        userId: entity.userId,
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        image: entity.image,
        quantity: entity.quantity,
        username: entity.username,
        payment: entity.payment,
      );

  List<OrderApiModel> toApiModelList(List<OrderEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  //From Json
  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);

  @override
  String toString() {
    return 'orderId: $orderId, userId: $userId, productId: $productId';
  }
}

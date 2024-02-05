// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      orderId: json['_id'] as String?,
      userId: json['user'] as String,
      productId: json['product'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      quantity: json['quantity'] as int?,
      username: json['username'] as String,
      payment: json['payment'] as bool,
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'user': instance.userId,
      'product': instance.productId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.quantity,
      'username': instance.username,
      'payment': instance.payment,
    };

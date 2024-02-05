// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      cartId: json['_id'] as String?,
      userId: json['user'] as String,
      productId: json['product'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.cartId,
      'user': instance.userId,
      'product': instance.productId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.quantity,
    };

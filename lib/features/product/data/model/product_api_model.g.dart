// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      productImage: json['productImage'] as String?,
      productName: json['productName'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productImage': instance.productImage,
      'productName': instance.productName,
      'price': instance.price,
      'category': instance.category,
      'desc': instance.desc,
    };

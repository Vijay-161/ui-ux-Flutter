import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constants.dart';

part 'product_hive_model.g.dart';

final productHiveModelProvider = Provider(
  (ref) => ProductHiveModel.empty(),
);
@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String productImage;

  @HiveField(3)
  final int price;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String desc;

  ProductHiveModel(
      {String? productId,
      required this.productImage,
      required this.productName,
      required this.price,
      required this.category,
      required this.desc})
      : productId = productId ?? const Uuid().v4();

  ProductHiveModel.empty()
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

  ProductHiveModel toHiveModel(ProductEntity entity) => ProductHiveModel(
        productId: const Uuid().v4(),
        productImage: entity.productImage!,
        productName: entity.productName,
        price: entity.price,
        category: entity.category,
        desc: entity.desc,
      );

  List<ProductHiveModel> toHiveModelList(List<ProductEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  List<ProductEntity> toEntityList(List<ProductHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'productId: $productId, name: $productName, price: $price, category: $category, desc: $desc';
  }
}

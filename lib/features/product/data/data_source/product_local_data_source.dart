import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/network/local/hive_service.dart';
import 'package:shoe_store/features/product/data/model/product_hive_model.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';

import '../../../../core/failure/failure.dart';

final productLocalDataSourceProvider = Provider((ref) {
  return ProductLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(productHiveModelProvider),
  );
});

class ProductLocalDataSource {
  final HiveService _hiveService;
  final ProductHiveModel _productHiveModel;

  ProductLocalDataSource(this._hiveService, this._productHiveModel);

  //Add Product
  Future<Either<Failure, bool>> addProduct(ProductEntity product) async {
    try {
      // Convert Entity to Hive Object
      final hiveProduct = _productHiveModel.toHiveModel(product);
      // Add to Hive
      await _hiveService.addProduct(hiveProduct);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      // Get all batches from Hive
      final products = await _hiveService.getAllProducts();
      // Convert Hive Object to Entity
      final productEntities = _productHiveModel.toEntityList(products);
      return Right(productEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}

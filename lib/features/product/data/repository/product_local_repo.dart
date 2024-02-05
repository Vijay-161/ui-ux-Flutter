import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/product/data/data_source/product_local_data_source.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:shoe_store/features/product/domain/repository/product_repository.dart';

final productLocalRepoProvider = Provider((ref) => ProductLocalRepository(
      ref.read(productLocalDataSourceProvider),
    ));

class ProductLocalRepository implements IProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  ProductLocalRepository(this.productLocalDataSource);

  @override
  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productLocalDataSource.addProduct(product);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productLocalDataSource.getAllProducts();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, ProductEntity>> getProductById(String productId) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> editProduct(String productId, ProductEntity product) {
    // TODO: implement editProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getByCategory(String category) {
    // TODO: implement getByCategory
    throw UnimplementedError();
  }

}

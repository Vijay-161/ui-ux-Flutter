import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/product/data/data_source/product_remote_data_source.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:shoe_store/features/product/domain/repository/product_repository.dart';

final productRemoteRepoProvider = Provider(
  (ref) => ProductRemoteRepository(
    productRemoteDataSource: ref.read(productRemoteDataSourceProvider),
  ),
);

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepository({
    required this.productRemoteDataSource,
  });
  @override
  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productRemoteDataSource.addProduct(product);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRemoteDataSource.getAllProducts();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return productRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String productId) {
    return productRemoteDataSource.getProductById(productId);
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String productId) {
    return productRemoteDataSource.deleteProduct(productId);
  }

  @override
  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product) {
    return productRemoteDataSource.editProduct(productId, product);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getByCategory(String category) {
    return productRemoteDataSource.getByCategory(category);
  }
}

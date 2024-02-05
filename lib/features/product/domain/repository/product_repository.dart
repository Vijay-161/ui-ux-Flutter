import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../data/repository/product_local_repo.dart';
import '../../data/repository/product_remote_repo.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) {
    // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(productRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(productLocalRepoProvider);
    }
    // return ref.watch(productLocalRepoProvider);
  },
);

abstract class IProductRepository {
  Future<Either<Failure, bool>> addProduct(ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, ProductEntity>> getProductById(String productId);
  Future<Either<Failure, bool>> deleteProduct(String productId);
  Future<Either<Failure, List<ProductEntity>>> getByCategory(String category);
  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product);
}

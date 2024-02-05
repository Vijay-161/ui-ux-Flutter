import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:shoe_store/features/product/domain/repository/product_repository.dart';

import '../../../../core/failure/failure.dart';

final productUseCaseProvider = Provider(
  (ref) => ProductUseCase(
    productRepository: ref.read(productRepositoryProvider),
  ),
);

class ProductUseCase {
  final IProductRepository productRepository;

  ProductUseCase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRepository.getAllProducts();
  }

  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productRepository.addProduct(product);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await productRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, ProductEntity>> getProductById(String productId) {
    return productRepository.getProductById(productId);
  }

  Future<Either<Failure, bool>> deleteProduct(String productId) {
    return productRepository.deleteProduct(productId);
  }

  Future<Either<Failure, List<ProductEntity>>> getByCategory(String category) {
    return productRepository.getByCategory(category);
  }

  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product) {
    return productRepository.editProduct(productId, product);
  }
}

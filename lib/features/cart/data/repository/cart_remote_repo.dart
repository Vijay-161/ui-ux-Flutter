import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';
import 'package:shoe_store/features/cart/domain/repository/cart_repository.dart';

final cartRemoteRepoProvider = Provider(
  (ref) => CartRemoteRepository(
    cartRemoteDataSource: ref.read(cartRemoteDataSourceProvider),
  ),
);

class CartRemoteRepository implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepository({
    required this.cartRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> addCart(CartEntity cart) {
    return cartRemoteDataSource.addCart(cart);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCarts() {
    return cartRemoteDataSource.getAllCarts();
  }

  @override
  Future<Either<Failure, bool>> deleteCart(String cartId) {
    return cartRemoteDataSource.deleteCart(cartId);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCart(String user) {
    return cartRemoteDataSource.getCart(user);
  }

  @override
  Future<Either<Failure, bool>> editCart(String cartId, int quantity) {
    return cartRemoteDataSource.editCart(cartId, quantity);
  }

  @override
  Future<Either<Failure, CartEntity>> getCartById(String cartId) {
    return cartRemoteDataSource.getCartById(cartId);
  }
}

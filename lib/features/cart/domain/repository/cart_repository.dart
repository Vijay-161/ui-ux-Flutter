import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/cart_remote_repo.dart';

final cartRepositoryProvider = Provider<ICartRepository>((ref) {
  return ref.watch(cartRemoteRepoProvider);
});

abstract class ICartRepository {
  Future<Either<Failure, bool>> addCart(CartEntity cart);
  Future<Either<Failure, List<CartEntity>>> getAllCarts();
  Future<Either<Failure, List<CartEntity>>> getCart(String user);
  Future<Either<Failure, bool>> deleteCart(String cartId);
  Future<Either<Failure, bool>> editCart(String cartId, int quantity);
  Future<Either<Failure, CartEntity>> getCartById(String cartId);
}

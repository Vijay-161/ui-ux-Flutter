import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';
import 'package:shoe_store/features/cart/domain/repository/cart_repository.dart';

import '../../../../core/failure/failure.dart';

final cartUseCaseProvider = Provider(
  (ref) => CartUseCase(cartRepository: ref.read(cartRepositoryProvider)),
);

class CartUseCase {
  final ICartRepository cartRepository;

  CartUseCase({
    required this.cartRepository,
  });

  Future<Either<Failure, List<CartEntity>>> getAllCarts() {
    return cartRepository.getAllCarts();
  }

  Future<Either<Failure, bool>> addCart(CartEntity cart) {
    return cartRepository.addCart(cart);
  }

  Future<Either<Failure, bool>> deleteCart(String cartId) {
    return cartRepository.deleteCart(cartId);
  }

  Future<Either<Failure, List<CartEntity>>> getCart(String user) {
    return cartRepository.getCart(user);
  }

  Future<Either<Failure, bool>> editCart(String cartId, int quantity) {
    return cartRepository.editCart(cartId, quantity);
  }

  Future<Either<Failure, CartEntity>> getCartById(String cartId) {
    return cartRepository.getCartById(cartId);
  }
}

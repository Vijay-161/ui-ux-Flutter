import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/order/domain/entity/order_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/order_remote_repo.dart';

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  return ref.watch(orderRemoteRepoProvider);
});

abstract class IOrderRepository {
  Future<Either<Failure, bool>> addOrder(OrderEntity order);
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, List<OrderEntity>>> getOrder(String userId);
  Future<Either<Failure, bool>> deleteOrder(String orderId);
  // Future<Either<Failure, bool>> editCart(String cartId, int quantity);
  // Future<Either<Failure, CartEntity>> getCartById(String cartId);
}
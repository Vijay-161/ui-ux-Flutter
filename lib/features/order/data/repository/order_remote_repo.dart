import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/order/data/data_source/order_remote_data_source.dart';

import 'package:shoe_store/features/order/domain/entity/order_entity.dart';

import '../../domain/repository/order_repository.dart';

final orderRemoteRepoProvider = Provider(
  (ref) => OrderRemoteRepository(
    orderRemoteDataSource: ref.read(orderRemoteDataSourceProvider),
  ),
);

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRemoteRepository({
    required this.orderRemoteDataSource,
  });
  @override
  Future<Either<Failure, bool>> addOrder(OrderEntity order) {
    return orderRemoteDataSource.addOrder(order);
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(String orderId) {
    return orderRemoteDataSource.deleteOrder(orderId);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return orderRemoteDataSource.getAllOrders();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder(String userId) {
    return orderRemoteDataSource.getOrder(userId);
  }
}

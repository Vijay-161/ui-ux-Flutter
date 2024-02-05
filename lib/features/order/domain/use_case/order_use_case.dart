import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/order/domain/entity/order_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/order_repository.dart';

final orderUseCaseProvider = Provider(
  (ref) => OrderUseCase(orderRepository: ref.read(orderRepositoryProvider)),
);

class OrderUseCase {
  final IOrderRepository orderRepository;

  OrderUseCase({
    required this.orderRepository,
  });

  Future<Either<Failure, bool>> addOrder(OrderEntity order) {
    return orderRepository.addOrder(order);
  }
  Future<Either<Failure, bool>> deleteOrder(String orderId) {
    return orderRepository.deleteOrder(orderId);
  }

  Future<Either<Failure, List<OrderEntity>>> getOrder(String userId) {
    return orderRepository.getOrder(userId);
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return orderRepository.getAllOrders();
  }
}

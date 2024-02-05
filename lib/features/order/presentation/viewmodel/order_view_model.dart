import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/use_case/order_use_case.dart';
import '../state/order_state.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(
    ref.read(orderUseCaseProvider),
  ),
);

class OrderViewModel extends StateNotifier<OrderState> {
  final OrderUseCase orderUseCase;

  OrderViewModel(this.orderUseCase) : super(OrderState.initial()) {
    // getAllCarts();
  }

  Future<void> addOrder(OrderEntity order) async {
    state.copyWith(isLoading: true);
    var data = await orderUseCase.addOrder(order);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> getAllOrders() async {
    state = state.copyWith(isLoading: true);
    var data = await orderUseCase.getAllOrders();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, orders: r),
    );
  }

  Future<void> getOrder(BuildContext context, String userId) async {
    state = state.copyWith(isLoading: true);
    var data = await orderUseCase.getOrder(userId);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, orders: r),
    );
  }

  Future<void> deleteOrder(BuildContext context, OrderEntity order) async {
    state.copyWith(isLoading: true);
    var data = await orderUseCase.deleteOrder(order.orderId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.orders.remove(order);
        state = state.copyWith(isLoading: false, error: null);
        // showSnackBar(
        //   message: 'Product deleted successfully',
        //   context: context,
        // );
      },
    );
  }
}

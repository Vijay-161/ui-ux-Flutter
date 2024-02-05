import 'package:shoe_store/features/order/domain/entity/order_entity.dart';

class OrderState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final String? error;

  OrderState({
    required this.isLoading,
    required this.orders,

    this.error,
  });

  factory OrderState.initial() {
    return OrderState(
      isLoading: false,
      orders: [],
    );
  }

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}

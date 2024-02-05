import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';

class CartState {
  final bool isLoading;
  final List<CartEntity> carts;
  final List<CartEntity> allcarts;
  final String? error;
  final CartEntity? singleCart;

  CartState({
    required this.isLoading,
    required this.carts,
    required this.allcarts,
    this.singleCart,
    this.error,
  });

  factory CartState.initial() {
    return CartState(
      isLoading: false,
      carts: [],
      allcarts: [],
      singleCart: null,
    );
  }

  CartState copyWith({
    bool? isLoading,
    List<CartEntity>? carts,
    List<CartEntity>? allcarts,
    String? error,
    CartEntity? singleCart,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      error: error ?? this.error,
      allcarts: allcarts ?? this.allcarts,
      singleCart: singleCart ?? this.singleCart,
    );
  }
}

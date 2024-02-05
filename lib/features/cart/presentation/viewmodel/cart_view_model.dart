import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';
import 'package:shoe_store/features/cart/domain/use_case/cart_use_case.dart';
import 'package:shoe_store/features/cart/presentation/state/cart_state.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
    ref.read(cartUseCaseProvider),
  ),
);

class CartViewModel extends StateNotifier<CartState> {
  final CartUseCase cartUseCase;

  CartViewModel(this.cartUseCase) : super(CartState.initial()) {
    getAllCarts();
  }

  Future<void> addCart(CartEntity cart) async {
    state.copyWith(isLoading: true);
    var data = await cartUseCase.addCart(cart);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> getAllCarts() async {
    state = state.copyWith(isLoading: true);
    var data = await cartUseCase.getAllCarts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, allcarts: r),
    );
  }

  Future<void> getCart(BuildContext context, String user) async {
    state = state.copyWith(isLoading: true);
    var data = await cartUseCase.getCart(user);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, carts: r),
    );
  }

  Future<void> deleteCart(BuildContext context, CartEntity cart) async {
    state.copyWith(isLoading: true);
    var data = await cartUseCase.deleteCart(cart.cartId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.carts.remove(cart);
        state = state.copyWith(isLoading: false, error: null);
        // showSnackBar(
        //   message: 'Product deleted successfully',
        //   context: context,
        // );
      },
    );
  }

  // CartEntity cart
  Future<void> editCart(
      BuildContext context, String cartId, int quantity) async {
    state = state.copyWith(isLoading: true);

    var data = await cartUseCase.editCart(cartId, quantity);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );

        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);

        showSnackBar(
          message: 'Cart Updated successfully',
          context: context,
        );
      },
    );
  }

  Future<void> getCartById(BuildContext context, String cartId) async {
    state = state.copyWith(isLoading: true);
    var data = await cartUseCase.getCartById(cartId);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, singleCart: r, error: null);
        Navigator.pushNamed(context, AppRoute.payChooseRoute);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:shoe_store/features/cart/presentation/widget/load_cart.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  Widget build(BuildContext context) {
    var cartState = ref.watch(cartViewModelProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'My Cart',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (cartState.isLoading) ...{
            const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 2, 73, 4),
              )),
            )
          } else if (cartState.carts.isNotEmpty) ...{
            Flexible(
              child: LoadCart(ref: ref, lstCarts: cartState.carts),
            ),
          } else ...{
            const Text(
              "Cart Empty",
              style: TextStyle(color: Colors.red, fontSize: 20),
            )
          }
        ]),
      ),
    );
  }
}

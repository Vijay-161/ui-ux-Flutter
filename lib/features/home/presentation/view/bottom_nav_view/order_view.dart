import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:shoe_store/features/order/presentation/widget/order_card.dart';

class OrderView extends ConsumerStatefulWidget {
  const OrderView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderViewState();
}

class _OrderViewState extends ConsumerState<OrderView> {
  @override
  Widget build(BuildContext context) {
    var orderState = ref.watch(orderViewModelProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (orderState.isLoading) ...{
            const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 2, 73, 4),
              )),
            )
          } else if (orderState.orders.isNotEmpty) ...{
            Flexible(
              child: CardOrder(ref: ref, lstOrders: orderState.orders),
            ),
          } else ...{
            const Text(
              "Order Empty",
              style: TextStyle(color: Colors.red, fontSize: 20),
            )
          }
        ]),
      ),
    );
  }
}

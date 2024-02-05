import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../order/presentation/viewmodel/order_view_model.dart';
import '../../widget/load_all_order.dart';

class AdminOrderView extends ConsumerStatefulWidget {
  const AdminOrderView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminOrderViewState();
}

class _AdminOrderViewState extends ConsumerState<AdminOrderView> {
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
              'All Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (orderState.orders.isNotEmpty) ...{
            Flexible(
              child: LoadAllOrder(ref: ref, lstOrders: orderState.orders),
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

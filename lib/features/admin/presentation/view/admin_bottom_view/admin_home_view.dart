import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/admin/presentation/widget/load_product.dart';

import '../../../../../config/routes/app_route.dart';
import '../../../../product/presentation/viewmodel/product_view_model.dart';

class AdminHomeView extends ConsumerStatefulWidget {
  const AdminHomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends ConsumerState<AdminHomeView> {
  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addProductRoute);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Add Product',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, AppRoute.accelerometerRoute);
          //     },
          //     child: const Text('Sensors')),
          Flexible(
            child: LoadProduct(ref: ref, lstProducts: productState.products),
          ),
          // SizedBox(
          //   width: 200,
          //   child: FloatingActionButton(
          //     onPressed: () {},
          //     backgroundColor: const Color.fromARGB(255, 9, 95, 12),
          //     child: const Text('Add Product'),
          //   ),
          // ),
          // const SizedBox(height: 5),
        ],
      ),
    );
  }
}

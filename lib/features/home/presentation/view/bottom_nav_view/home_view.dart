import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/home/presentation/widget/product_widget.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    ref
                        .read(productViewModelProvider.notifier)
                        .getAllProducts();
                  },
                  child: const Text(
                    'All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(productViewModelProvider.notifier)
                        .getByCategory(context, "Men");
                  },
                  child: const Text('Men',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(productViewModelProvider.notifier)
                        .getByCategory(context, "Women");
                  },
                  child: const Text('Women',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(productViewModelProvider.notifier)
                        .getByCategory(context, "Children");
                  },
                  child: const Text('Children',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                ),
              ],
            ),
            Flexible(
              child: BatchWidget(ref: ref, productList: productState.products),
            ),
          ],
        ),
      ),
    );
  }
}

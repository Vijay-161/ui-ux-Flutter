import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../product/domain/entity/product_entity.dart';

class BatchWidget extends StatelessWidget {
  final WidgetRef ref;
  final List<ProductEntity> productList;

  const BatchWidget({
    super.key,
    required this.ref,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Put this otherwise it will take all the space
      shrinkWrap: true,
      itemCount: productList.length,
      // physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            ref
                .read(productViewModelProvider.notifier)
                .getProductById(context, productList[index].productId!);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 199, 217, 226),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                const SizedBox(height: 10),
                Container(
                  height: 130,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: productList[index].productImage != null
                            ? NetworkImage(ApiEndpoints.imageUrl +
                                productList[index].productImage!)
                            : const NetworkImage(
                                'https://rukminim1.flixcart.com/image/450/500/xif0q/shoe/j/q/n/8-mrj2100-8-aadi-white-black-grey-original-imagn8yk5hfq7vnh.jpeg?q=90&crop=false'),
                        fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productList[index].productName,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Rs.${productList[index].price}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 214, 34, 21),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}

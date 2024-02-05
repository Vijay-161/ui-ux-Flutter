import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/config/constants/api_endpoint.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:shoe_store/features/product/presentation/view/edit_product.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

class LoadProduct extends StatelessWidget {
  final WidgetRef ref;
  final List<ProductEntity> lstProducts;
  const LoadProduct({super.key, required this.lstProducts, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lstProducts.length,
      itemBuilder: ((context, index) => ListTile(
          // leading: CircleAvatar(
          //   radius: 60,
          //   backgroundImage: NetworkImage(
          //     ApiEndpoints.imageUrl + lstProducts[index].productImage!,
          //   ),
          //   backgroundColor: Colors.transparent,
          // ),
          leading: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                  image: lstProducts[index].productImage != null
                      ? NetworkImage(ApiEndpoints.imageUrl +
                          lstProducts[index].productImage!)
                      : const NetworkImage(
                          'https://rukminim1.flixcart.com/image/450/500/xif0q/shoe/j/q/n/8-mrj2100-8-aadi-white-black-grey-original-imagn8yk5hfq7vnh.jpeg?q=90&crop=false'),
                  fit: BoxFit.fill),
            ),
          ),
          title: Text(
            lstProducts[index].productName,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          subtitle: Text(lstProducts[index].price.toString()),
          trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                          'Are you sure you want to delete ${lstProducts[index].productName}?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref
                                  .read(productViewModelProvider.notifier)
                                  .deleteProduct(context, lstProducts[index]);
                            },
                            child: const Text('Yes')),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  // ref
                  //     .read(productViewModelProvider.notifier)
                  //     .getProductToEdit(context, lstProducts[index].productId!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProductView(product: lstProducts[index]),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ))),
    );
  }
}

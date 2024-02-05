import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/config/constants/api_endpoint.dart';
import 'package:shoe_store/features/order/domain/entity/order_entity.dart';
import 'package:shoe_store/features/order/presentation/viewmodel/order_view_model.dart';

class CardOrder extends StatelessWidget {
  final WidgetRef ref;
  final List<OrderEntity> lstOrders;
  const CardOrder({super.key, required this.lstOrders, required this.ref});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: lstOrders.length,
      itemBuilder: ((context, index) => InkWell(
                onDoubleTap: () {
                  ref
                      .read(orderViewModelProvider.notifier)
                      .deleteOrder(context, lstOrders[index]);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First Column - Image
                        Container(
                          width: width / 4,
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0XFFD4ECF7),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(ApiEndpoints.imageUrl +
                                    lstOrders[index].image),
                                fit: BoxFit.fill),
                          ),
                        ),

                        // Second Column - Name and Price
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lstOrders[index].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rs. ${lstOrders[index].price * lstOrders[index].quantity!}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 34, 33, 33),
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'QTY: ${lstOrders[index].quantity.toString()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Third Column - Payment Status and Cancel Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const Text(
                            //   'Payment Status: Pending',
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: Colors.orange,
                            //   ),
                            // ),
                            lstOrders[index].payment != true
                                ? const Text(
                                    'Unpaid',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Text(
                                    'Paid',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            ElevatedButton(
                              onPressed: () {
                                // Add your cancel button functionality here
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          // itemBuilder: ((context, index) => InkWell(
          //       onDoubleTap: () => {},
          //       child: ListTile(
          //         // leading: const Icon(Icons.person),
          //         leading: Container(
          //           height: 100,
          //           width: 100,
          //           decoration: BoxDecoration(
          //             borderRadius: const BorderRadius.all(Radius.circular(50)),
          //             image: DecorationImage(
          //                 image: NetworkImage(
          //                     ApiEndpoints.imageUrl + lstCarts[index].image),
          //                 fit: BoxFit.fill),
          //           ),
          //         ),
          //         title: Text(
          //           lstCarts[index].name,
          //         ),
          //         subtitle: Text(
          //           ' Rs. ${lstCarts[index].price}',
          //           style: const TextStyle(
          //             color: Colors.red,
          //           ),
          //         ),
          //         trailing: Wrap(children: [
          //           IconButton(
          //             onPressed: () {},
          //             icon: const Icon(CupertinoIcons.plus),
          //           ),
          //           Text(
          //             count.toString(),
          //             style: const TextStyle(
          //               fontSize: 18,
          //             ),
          //           ),
          //           IconButton(
          //             onPressed: () {},
          //             icon: const Icon(CupertinoIcons.minus),
          //           ),
          //           ElevatedButton(onPressed: () {}, child: const Text('Order'))
          //         ]),
          //         // trailing: Wrap(
          //         //   children: [
          //         //     IconButton(
          //         //       onPressed: () {
          //         //         showDialog(
          //         //           context: context,
          //         //           builder: (context) => AlertDialog(
          //         //             title: Text(
          //         //                 'Are you sure you want to delete ${lstProducts[index].productName}?'),
          //         //             actions: [
          //         //               TextButton(
          //         //                   onPressed: () {
          //         //                     Navigator.pop(context);
          //         //                   },
          //         //                   child: const Text('No')),
          //         //               TextButton(
          //         //                   onPressed: () {
          //         //                     Navigator.pop(context);
          //         //                     ref
          //         //                         .read(productViewModelProvider.notifier)
          //         //                         .deleteProduct(context, lstProducts[index]);
          //         //                   },
          //         //                   child: const Text('Yes')),
          //         //             ],
          //         //           ),
          //         //         );
          //         //       },
          //         //       icon: const Icon(Icons.delete),
          //         //     ),
          //         //     IconButton(
          //         //       onPressed: () {
          //         //         // ref
          //         //         //     .read(productViewModelProvider.notifier)
          //         //         //     .getProductToEdit(context, lstProducts[index].productId!);
          //         //         Navigator.push(
          //         //           context,
          //         //           MaterialPageRoute(
          //         //             builder: (context) =>
          //         //                 EditProductView(product: lstProducts[index]),
          //         //           ),
          //         //         );
          //         //       },
          //         //       icon: const Icon(Icons.edit),
          //         //     ),
          //         //   ],
          //         // ),
          //       ),
          //     )),
          ),
    );
  }
}

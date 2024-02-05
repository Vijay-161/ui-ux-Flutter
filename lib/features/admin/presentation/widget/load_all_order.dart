import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../../order/presentation/viewmodel/order_view_model.dart';

class LoadAllOrder extends StatelessWidget {
  final WidgetRef ref;
  final List<OrderEntity> lstOrders;
  const LoadAllOrder({super.key, required this.lstOrders, required this.ref});

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
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 125,
                  width: width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
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
                      Flexible(
                        child: SizedBox(
                          width: width / 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 20, bottom: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text(
                                  'Rs. ${lstOrders[index].price * lstOrders[index].quantity!}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 34, 33, 33),
                                    fontSize: 18,
                                  ),
                                ),
                                Text(lstOrders[index].username),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 70,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      lstOrders[index].quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    const Spacer(),
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
                                    // Text(lstOrders[index].payment.toString()),
                                  ]),
                              TextButton(
                                  onPressed: () {
                                    ref
                                        .read(orderViewModelProvider.notifier)
                                        .deleteOrder(context, lstOrders[index]);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/config/routes/app_route.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';
import 'package:shoe_store/features/splash/presentation/viewmodel/splash_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../viewmodel/cart_view_model.dart';

class LoadCart extends StatelessWidget {
  final WidgetRef ref;
  final List<CartEntity> lstCarts;
  const LoadCart({super.key, required this.lstCarts, required this.ref});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var userState = ref.watch(authViewModelProvider);
    var splashState = ref.watch(splashViewModelProvider);
    return ListView.builder(
      itemCount: lstCarts.length,
      itemBuilder: ((context, index) => InkWell(
                onDoubleTap: () {
                  ref
                      .read(cartViewModelProvider.notifier)
                      .deleteCart(context, lstCarts[index]);
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
                                  lstCarts[index].image),
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
                                  lstCarts[index].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rs. ${lstCarts[index].price * lstCarts[index].quantity!}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 214, 34, 21),
                                    fontSize: 18,
                                  ),
                                ),
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
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                cartViewModelProvider.notifier)
                                            .editCart(
                                              context,
                                              lstCarts[index].cartId!,
                                              lstCarts[index].quantity! - 1,
                                            );
                                      },
                                      icon: const Icon(CupertinoIcons.minus),
                                    ),
                                    Text(
                                      lstCarts[index].quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                cartViewModelProvider.notifier)
                                            .editCart(
                                              context,
                                              lstCarts[index].cartId!,
                                              lstCarts[index].quantity! + 1,
                                            );
                                        ref
                                            .watch(
                                                cartViewModelProvider.notifier)
                                            .getCart(
                                              context,
                                              userState.currentUser != null
                                                  ? userState.currentUser!.id!
                                                  : splashState.user.id!,
                                            );
                                      },
                                      icon: const Icon(CupertinoIcons.plus),
                                    ),
                                  ]),
                              TextButton(
                                  onPressed: () {
                                    ref
                                        .read(cartViewModelProvider.notifier)
                                        .getCartById(
                                            context, lstCarts[index].cartId!);
                                    Navigator.pushNamed(
                                        context, AppRoute.payChooseRoute);
                                  },
                                  child: const Text(
                                    'Order',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
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

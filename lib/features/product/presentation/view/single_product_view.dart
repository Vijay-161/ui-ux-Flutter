import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';
import 'package:shoe_store/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../splash/presentation/viewmodel/splash_view_model.dart';

class SingleProductView extends ConsumerStatefulWidget {
  const SingleProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleProductViewState();
}

class _SingleProductViewState extends ConsumerState<SingleProductView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var productState = ref.read(productViewModelProvider);
    var userState = ref.read(authViewModelProvider);
    var splashState = ref.read(splashViewModelProvider);
    var cartState = ref.read(cartViewModelProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Single Product'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height / 2,
              width: width,
              decoration: const BoxDecoration(
                color: Color(0xFFD4ECF7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Container(
                // color: Colors.grey,
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: productState.singleProduct.productImage != null
                          ? NetworkImage(ApiEndpoints.imageUrl +
                              productState.singleProduct.productImage!)
                          : const NetworkImage(
                              'https://rukminim1.flixcart.com/image/450/500/xif0q/shoe/j/q/n/8-mrj2100-8-aadi-white-black-grey-original-imagn8yk5hfq7vnh.jpeg?q=90&crop=false'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SizedBox(
                height: height / 2,
                width: width,
                // color: const Color.fromARGB(255, 183, 206, 219),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productState.singleProduct.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs. ${productState.singleProduct.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productState.singleProduct.desc,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                var cart = CartEntity(
                  userId: userState.currentUser != null
                      ? userState.currentUser!.id!
                      : splashState.user.id!,
                  productId: productState.singleProduct.productId!,
                  name: productState.singleProduct.productName,
                  image: productState.singleProduct.productImage!,
                  price: productState.singleProduct.price,
                );
                ref.read(cartViewModelProvider.notifier).addCart(cart);

                if (cartState.error != null) {
                  showSnackBar(
                    message: cartState.error.toString(),
                    context: context,
                    color: Colors.red,
                  );
                } else {
                  showSnackBar(
                    message: 'Added to Cart',
                    context: context,
                  );
                }
              },
              child: Container(
                width: width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent,
                ),
                child: const Center(
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              color: Colors.redAccent,
              iconSize: 50,
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

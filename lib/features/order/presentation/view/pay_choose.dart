import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shoe_store/features/order/domain/entity/order_entity.dart';
import 'package:shoe_store/features/order/presentation/viewmodel/order_view_model.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../cart/presentation/viewmodel/cart_view_model.dart';
import '../../../splash/presentation/viewmodel/splash_view_model.dart';

class ChoosePay extends ConsumerStatefulWidget {
  const ChoosePay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChoosePayState();
}

class _ChoosePayState extends ConsumerState<ChoosePay> {
  String referenceId = "";
  bool paymentSuccess = false;

  @override
  Widget build(BuildContext context) {
    var cartState = ref.read(cartViewModelProvider);
    var userState = ref.read(authViewModelProvider);
    var splashState = ref.read(splashViewModelProvider);
    var orderState = ref.read(orderViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment'),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              payWithKhaltiInApp();
            },
            child: const Text(
              'Pay with Khalti',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var order = OrderEntity(
                userId: cartState.singleCart!.userId,
                productId: cartState.singleCart!.productId,
                name: cartState.singleCart!.name,
                image: cartState.singleCart!.image,
                price: cartState.singleCart!.price,
                quantity: cartState.singleCart!.quantity,
                username: userState.currentUser != null
                    ? userState.currentUser!.username
                    : splashState.user.username,
                payment: false,
              );

              ref.read(orderViewModelProvider.notifier).addOrder(order);

              if (orderState.error != null) {
                showSnackBar(
                  message: cartState.error.toString(),
                  context: context,
                  color: Colors.red,
                );
              } else {
                showSnackBar(
                  message: 'Order Success',
                  context: context,
                );
              }
            },
            child: const Text(
              'Cash on Delivery',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    var cartState = ref.read(cartViewModelProvider);
    var userState = ref.read(authViewModelProvider);
    var splashState = ref.read(splashViewModelProvider);
    var orderState = ref.read(orderViewModelProvider);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    referenceId = success.idx;
                  });

                  var order = OrderEntity(
                    userId: cartState.singleCart!.userId,
                    productId: cartState.singleCart!.productId,
                    name: cartState.singleCart!.name,
                    image: cartState.singleCart!.image,
                    price: cartState.singleCart!.price,
                    quantity: cartState.singleCart!.quantity,
                    username: userState.currentUser != null
                        ? userState.currentUser!.username
                        : splashState.user.username,
                    payment: true,
                  );

                  ref.read(orderViewModelProvider.notifier).addOrder(order);

                  if (orderState.error != null) {
                    showSnackBar(
                      message: cartState.error.toString(),
                      context: context,
                      color: Colors.red,
                    );
                  } else {
                    showSnackBar(
                      message: 'Order Successful',
                      context: context,
                    );
                  }

                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}

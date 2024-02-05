import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/config/constants/app_color_constant.dart';
import 'package:shoe_store/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';
import 'admin_bottom_view/admin_cart_view.dart';
import 'admin_bottom_view/admin_home_view.dart';
import 'admin_bottom_view/admin_order_view.dart';
import 'admin_bottom_view/admin_profile_view.dart';

class AdminDashboardView extends ConsumerStatefulWidget {
  const AdminDashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminDashboardViewState();
}

class _AdminDashboardViewState extends ConsumerState<AdminDashboardView> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const AdminHomeView(),
    const AdminCartView(),
    const AdminOrderView(),
    const AdminProfileView(),
  ];

  List<double> _accelerometerValue = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(accelerometerEvents!.listen((event) {
      setState(() {
        _accelerometerValue = [event.x, event.y, event.z];
      });
    }));
    super.initState();
  }

  final GlobalKey _buttonKey = GlobalKey();

  @override
  void dispose() {
    // Cancel all stream subscriptions when the widget is disposed
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldTapButtonAutomatically =
        _accelerometerValue[0] >= 5 && _accelerometerValue[2] >= 5;

    if (shouldTapButtonAutomatically) {
      // Automatic tap when the condition is met
      Future.delayed(const Duration(milliseconds: 200), () {
        final dynamic button = _buttonKey.currentWidget;
        button.onPressed(); // Simulate tap on the button
      });
      setState(() {
        shouldTapButtonAutomatically = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            key: _buttonKey,
            onPressed: () {
              ref.read(productViewModelProvider.notifier).getAllProducts();
              // ref.read(courseViewModelProvider.notifier).getCourses();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColorConstant.appBarColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            ref.read(orderViewModelProvider.notifier).getAllOrders();
          }
        },
      ),
    );
  }
}

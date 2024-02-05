import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:shoe_store/features/home/presentation/view/bottom_nav_view/cart_view.dart';
import 'package:shoe_store/features/home/presentation/view/bottom_nav_view/home_view.dart';
import 'package:shoe_store/features/home/presentation/view/bottom_nav_view/order_view.dart';
import 'package:shoe_store/features/home/presentation/view/bottom_nav_view/profile_view.dart';
import 'package:shoe_store/features/order/presentation/viewmodel/order_view_model.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../splash/presentation/viewmodel/splash_view_model.dart';
import '../viewmodel/home_view_model.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeView(),
    const CartView(),
    const OrderView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);
    var splashState = ref.watch(splashViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(batchViewModelProvider.notifier).getBatches();
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
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
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
          if (index == 1) {
            ref.watch(cartViewModelProvider.notifier).getCart(
                  context,
                  userState.currentUser != null
                      ? userState.currentUser!.id!
                      : splashState.user.id!,
                );
          }
          if (index == 2) {
            ref.watch(orderViewModelProvider.notifier).getOrder(
                  context,
                  userState.currentUser != null
                      ? userState.currentUser!.id!
                      : splashState.user.id!,
                );
          }
        },
      ),
    );
  }
}

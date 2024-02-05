import 'package:shoe_store/features/admin/presentation/view/admin_dash_view.dart';
import 'package:shoe_store/features/auth/presentation/view/login_view.dart';
import 'package:shoe_store/features/order/presentation/view/pay_choose.dart';
import 'package:shoe_store/features/product/presentation/view/add_product.dart';
import 'package:shoe_store/features/product/presentation/view/single_product_view.dart';
import 'package:shoe_store/features/splash/presentation/view/splash_view.dart';

import '../../features/auth/presentation/view/register_view.dart';
import '../../features/home/presentation/view/bottom_nav_view/card_view.dart';
import '../../features/home/presentation/view/dashboard_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String adminDashboardRoute = '/admin_dashboard';
  static const String addProductRoute = '/add_product';
  static const String singleProductRoute = '/single_product';
  static const String payChooseRoute = '/pay_choose';
  static const String cardRoute = '/card_view';

  static getAppRoutes() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      adminDashboardRoute: (context) => const AdminDashboardView(),
      addProductRoute: (context) => const AddProductView(),
      singleProductRoute: (context) => const SingleProductView(),
      payChooseRoute: (context) => const ChoosePay(),
      cardRoute: (context) => const CardView(),
    };
  }
}

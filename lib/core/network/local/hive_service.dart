import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoe_store/features/product/data/model/product_hive_model.dart';

import '../../../config/constants/hive_table_constants.dart';
import '../../../features/auth/data/model/auth_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(ProductHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());

    // Add dummy data
    await addDummyProduct();
    // await addDummyCourse();
  }

  //---------------------Product--------------
  Future<void> addProduct(ProductHiveModel product) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.put(product.productId, product);
  }

  Future<List<ProductHiveModel>> getAllProducts() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    var products = box.values.toList();
    box.close();
    return products;
  }

  // ======================== Student Queries ========================
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> addDummyProduct() async {
    // check of batch box is empty
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    if (box.isEmpty) {
      final product1 = ProductHiveModel(
          productImage: 'assets/images/logo.jpg',
          productName: 'Remote F1',
          price: 330,
          category: 'Women',
          desc: 'good product');
      final product2 = ProductHiveModel(
          productImage: '',
          productName: 'Remote F2',
          price: 330,
          category: 'Women',
          desc: 'good product and cool');

      final product3 = ProductHiveModel(
          productImage: '',
          productName: 'Remote F4',
          price: 330,
          category: 'Women',
          desc: 'good product');

      List<ProductHiveModel> products = [product1, product2, product3];

      // Insert batch with key
      for (var product in products) {
        await addProduct(product);
      }
    }
  }

  Future<void> addDummyUser() async {
    // check of batch box is empty
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    if (box.isEmpty) {
      final user1 = AuthHiveModel(
        image: '',
        fullName: 'vijay singh',
        email: 'dummy@gmail.com',
        phone: '9845745458',
        gender: 'Male',
        address: "ktm",
        username: "hive",
        password: "hive",
      );
      final user2 = AuthHiveModel(
        image: '',
        fullName: 'alok singh',
        email: 'alok@gmail.com',
        phone: '9845748998',
        gender: 'Male',
        address: "Biratnagar",
        username: "local",
        password: "local",
      );

      List<AuthHiveModel> users = [user1, user2];

      // Insert batch with key
      for (var user in users) {
        await addUser(user);
      }
    }
  }
}

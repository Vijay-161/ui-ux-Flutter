import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/order_entity.dart';
import '../dto/get_all_order_dto.dart';
import '../model/order_api_model.dart';

final orderRemoteDataSourceProvider = Provider(
  (ref) => OrderRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    orderApiModel: ref.read(orderApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class OrderRemoteDataSource {
  final Dio dio;
  final OrderApiModel orderApiModel;
  final UserSharedPrefs userSharedPrefs;

  OrderRemoteDataSource({
    required this.dio,
    required this.orderApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addOrder(OrderEntity order) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createOrder,
        data: {
          "user": order.userId,
          "product": order.productId,
          "name": order.name,
          "price": order.price,
          "image": order.image,
          "quantity": order.quantity,
          "username": order.username,
          "payment": order.payment,
        },
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllOrder);
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllOrderDTO orderDTO = GetAllOrderDTO.fromJson(response.data);
        return Right(orderApiModel.toEntityList(orderDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteOrder(String orderId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteOrder + orderId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<OrderEntity>>> getOrder(String userId) async {
    try {
      var response = await dio.get(ApiEndpoints.getOrder, data: {
        "user": userId,
      });
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllOrderDTO orderDTO = GetAllOrderDTO.fromJson(response.data);
        return Right(orderApiModel.toEntityList(orderDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}

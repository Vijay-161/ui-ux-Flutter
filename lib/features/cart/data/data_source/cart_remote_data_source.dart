import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/cart/data/model/cart_api_model.dart';
import 'package:shoe_store/features/cart/domain/entity/cart_entity.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../dto/get_all_cart_dto.dart';

final cartRemoteDataSourceProvider = Provider(
  (ref) => CartRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    cartApiModel: ref.read(cartApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CartRemoteDataSource {
  final Dio dio;
  final CartApiModel cartApiModel;
  final UserSharedPrefs userSharedPrefs;

  CartRemoteDataSource({
    required this.dio,
    required this.cartApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addCart(CartEntity cart) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCart,
        data: {
          "user": cart.userId,
          "product": cart.productId,
          "name": cart.name,
          "price": cart.price,
          "image": cart.image,
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

  Future<Either<Failure, List<CartEntity>>> getAllCarts() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCart);
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllCartDTO productDTO = GetAllCartDTO.fromJson(response.data);
        return Right(cartApiModel.toEntityList(productDTO.data));
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

  Future<Either<Failure, bool>> deleteCart(String cartId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteCart + cartId,
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

  Future<Either<Failure, List<CartEntity>>> getCart(String user) async {
    try {
      var response = await dio.get(ApiEndpoints.getCart, data: {
        "user": user,
      });
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllCartDTO productDTO = GetAllCartDTO.fromJson(response.data);
        return Right(cartApiModel.toEntityList(productDTO.data));
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

  Future<Either<Failure, bool>> editCart(String cartId, int quantity) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.editCart + cartId,
        data: {
          "quantity": quantity,
        },
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

  Future<Either<Failure, CartEntity>> getCartById(
      String cartId) async {
    try {
      var response = await dio.get(ApiEndpoints.getSingleCart + cartId);
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        // GetAllProductDTO singleproductDTO =
        //     GetAllProductDTO.fromJson(response.data);

        // var product = (response.data['data'] as List)
        //     .map((pro) => ProductApiModel.fromJson(pro).toEntity())
        //     .toList();
        var cart =
            CartApiModel.fromJson(response.data['data']).toEntity();
        return Right(cart);
        // GetProductByIdDTO singleproductDTO =
        //     GetProductByIdDTO.fromJson(response.data);
        // return Right(productApiModel.toEntityList(singleproductDTO.data));
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

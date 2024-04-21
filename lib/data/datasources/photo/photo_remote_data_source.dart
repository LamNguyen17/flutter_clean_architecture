import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/gateway/rest_api_gateway.dart';
import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/data/models/photo/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<Either<Failure, dynamic>> getPhoto(String? query);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final RestApiGateway _restApiGateway;

  PhotoRemoteDataSourceImpl(this._restApiGateway);

  @override
  Future<Either<Failure, dynamic>> getPhoto(String? query) async {
    print('getPhoto: $query');
    try {
      final response = (query != null ? await _restApiGateway.dio
          .get("?key=10378494-67ad2479ecf48567970bc1f0e&q=$query&page=1&per_page=20") :
      await _restApiGateway.dio
          .get("?key=10378494-67ad2479ecf48567970bc1f0e&page=1&per_page=20"));
      print("getPhoto_response: $response");
      if (response.statusCode == 200) {
        var decode = Photos.fromJson(response.data);
        return Right(decode);
      } else {
        return const Left(ServerFailure('Lỗi xảy ra'));
      }
    } on DioError catch (error) {
      return const Left(ServerFailure('Lỗi xảy ra'));
    }
  }
}

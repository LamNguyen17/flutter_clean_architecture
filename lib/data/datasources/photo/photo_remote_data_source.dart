import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_clean_architecture/data/gateway/rest_api_gateway.dart';
import 'package:flutter_clean_architecture/data/models/photo/photo_model.dart';
import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';

abstract class PhotoRemoteDataSource {
  Future<Either<Failure, dynamic>> getPhoto(RequestPhoto? reqParams);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final RestApiGateway _restApiGateway;

  PhotoRemoteDataSourceImpl(this._restApiGateway);

  @override
  Future<Either<Failure, dynamic>> getPhoto(RequestPhoto? reqParams) async {
    try {
      final response = (reqParams?.query != null
          ? await _restApiGateway.dio.get(
              "?key=10378494-67ad2479ecf48567970bc1f0e&q=${reqParams?.query}&page=${reqParams?.page}&per_page=20")
          : await _restApiGateway.dio.get(
              "?key=10378494-67ad2479ecf48567970bc1f0e&page=${reqParams?.page}&per_page=20"));
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

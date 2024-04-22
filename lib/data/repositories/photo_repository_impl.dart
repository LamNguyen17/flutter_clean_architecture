import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture/data/datasources/photo/photo_remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/repositories/photo_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource _dataSource;

  PhotoRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, dynamic>> getPhoto(RequestPhoto? reqParams) async {
    return await _dataSource.getPhoto(reqParams);
  }
}

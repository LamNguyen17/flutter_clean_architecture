import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';

abstract class PhotoRepository {
  Future<Either<Failure, dynamic>> getPhoto(RequestPhoto? reqParams);
}
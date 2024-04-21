import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/repositories/photo_repository.dart';

class GetPhotoUseCase implements BaseUseCase<dynamic, String> {
  final PhotoRepository repository;
  GetPhotoUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> execute(String? query) async {
    return await repository.getPhoto(query);
  }
}

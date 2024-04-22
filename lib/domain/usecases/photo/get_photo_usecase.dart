import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/repositories/photo_repository.dart';

class GetPhotoUseCase implements BaseUseCase<dynamic, RequestPhoto> {
  final PhotoRepository repository;

  GetPhotoUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> execute(RequestPhoto? reqParams) async {
    return await repository.getPhoto(reqParams);
  }
}

class RequestPhoto extends Equatable {
  final String? query;
  final int page;

  const RequestPhoto({
    this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}

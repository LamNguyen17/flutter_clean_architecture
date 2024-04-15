import 'package:flutter_clean_architecture/data/datasources/photo/photo_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/photo_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_clean_architecture/data/gateway/memory_gateway.dart';
import 'package:flutter_clean_architecture/data/gateway/rest_api_gateway.dart';
import 'package:flutter_clean_architecture/data/gateway/storage_gateway.dart';

final injector = GetIt.instance;

Future<void> configureDI() async {
  injector.registerLazySingleton(() => RestApiGateway());
  injector.registerLazySingleton(() => MemoryGateway());
  injector.registerLazySingleton(() => StorageGateway());
  injectionBloc();
  injectionDomain();
  injectionData();
}

Future<void> injectionBloc() async {
  injector.registerFactory(() => PhotoCubit(
    injector.get<GetPhotoUseCase>(),
  ));
}

Future<void> injectionDomain() async {
  injector.registerLazySingleton(() => GetPhotoUseCase(
    injector.get<PhotoRepositoryImpl>(),
  ));
}

Future<void> injectionData() async {
  injector.registerLazySingleton(() => PhotoRemoteDataSourceImpl(
    injector.get<RestApiGateway>(),
  ));
  injector.registerLazySingleton(() => PhotoRepositoryImpl(
    injector.get<PhotoRemoteDataSourceImpl>(),
  ));
}
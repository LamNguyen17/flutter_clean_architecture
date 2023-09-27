import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_architecture/di/injection.dart';
import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final _getPhotoUseCase = injector.get<GetPhotoUseCase>();
  PhotoCubit() : super(const PhotoInitial());

  Future<void> onFetched() async {
    emit(const PhotoLoading());
    var result = await _getPhotoUseCase.execute(NoParams());
    return result.fold(
          (failure) => emit(PhotoError("Có lỗi xảy ra $failure")),
          (val) {
        emit(PhotoSuccess(val));
      },
    );
  }
}
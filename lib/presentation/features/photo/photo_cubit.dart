import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_architecture/domain/usecases/base_usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Input
  final Sink<String?> search;
  final Function0<void> getPhoto;
  final Function0<void> dispose;

  /// Output
  final Stream<PhotoState?> results$;

  factory PhotoCubit(final GetPhotoUseCase getPhoto) {
    final textChangesS = BehaviorSubject<String>();
    final getPhotoS = BehaviorSubject<void>();
    final results = textChangesS
        .distinct()
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap<PhotoState?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        return Stream<PhotoState?>.value(null);
      } else {
        return Stream.fromFuture(getPhoto.execute(searchTerm))
            .flatMap((either) => either.fold((error) {
                  return Stream<PhotoState?>.value(
                      PhotoError(error.message.toString()));
                }, (data) {
                  return Stream<PhotoState?>.value(PhotoLoaded(data));
                }))
            .startWith(const PhotoLoading())
            .onErrorReturnWith(
                (error, _) => const PhotoError("Đã có lỗi xảy ra"));
      }
    });
    // .flatMap((_) {
    // return Stream.fromFuture(getPhoto.execute('Hello'))
    //     .flatMap((either) => either.fold((error) {
    //           return Stream<PhotoState?>.value(
    //               PhotoError(error.message.toString()));
    //         }, (data) {
    //           return Stream<PhotoState?>.value(PhotoLoaded(data));
    //         }))
    //     .startWith(const PhotoLoading())
    //     .onErrorReturnWith(
    //         (error, _) => const PhotoError("Đã có lỗi xảy ra"));
    // }
    // );
    return PhotoCubit._(
      search: textChangesS.sink,
      results$: results,
      getPhoto: () => getPhotoS.add(null),
      dispose: () {
        textChangesS.close();
        getPhotoS.close();
      },
    );
  }

  PhotoCubit._({
    required this.search,
    required this.getPhoto,
    required this.results$,
    required this.dispose,
  }) : super(const PhotoInitial());
}

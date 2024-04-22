import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_architecture/data/models/photo/photo_model.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Input
  final Sink<String?> search;
  final Function0<void> dispose;
  final Function0<void> onLoadMore;
  final Function0<void> onRefresh;

  /// Output
  final Stream<PhotoState?> results$;

  factory PhotoCubit(final GetPhotoUseCase getPhoto) {
    final currentPage = BehaviorSubject<int>.seeded(1);
    final onLoadMore = BehaviorSubject<void>();
    final onRefresh = BehaviorSubject<void>();
    final textChangesS = BehaviorSubject<String>();
    final List<Hits> appendPhotos = [];

    final loadMore$ = onLoadMore.doOnData((event) {
      var nextPage = currentPage.value + 1;
      currentPage.add(nextPage);
    }).withLatestFrom(textChangesS, (_, s) => textChangesS.value);

    final refresh$ = onRefresh.doOnData((event) {
      currentPage.add(1);
    }).withLatestFrom(textChangesS, (_, s) => textChangesS.value);

    final search$ = textChangesS.doOnData((event) {
      currentPage.add(1);
    });

    final results = Rx.merge([refresh$, search$, loadMore$])
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap((String keyword) {
      if (keyword.isEmpty) {
        return Stream.value(null);
      } else {
        return Stream.fromFuture(getPhoto
                .execute(RequestPhoto(query: keyword, page: currentPage.value)))
            .flatMap((either) => either.fold((error) {
                  return Stream<PhotoState?>.value(
                      PhotoError(error.message.toString()));
                }, (data) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (currentPage.value == 1) {
                    appendPhotos.clear();
                  }
                  appendPhotos.addAll(data.hits);
                  return Stream<PhotoState?>.value(PhotoLoaded(
                      data: appendPhotos,
                      currentPage: currentPage.value,
                      hasReachedMax: appendPhotos.length < data?.totalHits));
                }))
            .startWith(const PhotoLoading())
            .onErrorReturnWith(
                (error, _) => const PhotoError("Đã có lỗi xảy ra"));
      }
    });
    return PhotoCubit._(
      search: textChangesS.sink,
      onLoadMore: () => onLoadMore.add(null),
      onRefresh: () => onRefresh.add(null),
      results$: results,
      dispose: () {
        textChangesS.close();
        currentPage.close();
        onLoadMore.close();
        onRefresh.close();
      },
    );
  }

  PhotoCubit._({
    required this.search,
    required this.onRefresh,
    required this.onLoadMore,
    required this.results$,
    required this.dispose,
  }) : super(const PhotoInitial());
}

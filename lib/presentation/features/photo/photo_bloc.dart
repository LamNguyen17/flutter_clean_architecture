import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_clean_architecture/domain/entities/photo/photo.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoBloc {
  /// Input
  final Sink<String?> search;
  final Sink<void> onLoadMore;
  final Function0<void> dispose;
  final Sink<void> onRefresh;

  /// Output
  final Stream<PhotoState?> results$;

  factory PhotoBloc(final GetPhotoUseCase getPhoto) {
    final currentPage = BehaviorSubject<int>.seeded(1);
    final loadMoreS = BehaviorSubject<void>();
    final refreshS = BehaviorSubject<void>();
    final textChangesS = BehaviorSubject<String>();
    final List<Hits> appendPhotos = [];

    final loadMore$ = loadMoreS.doOnData((event) {
      var nextPage = currentPage.value + 1;
      currentPage.add(nextPage);
    }).withLatestFrom(textChangesS, (_, s) => textChangesS.value);

    final refresh$ = refreshS.doOnData((event) {
      currentPage.add(1);
    }).withLatestFrom(textChangesS, (_, s) => textChangesS.value);

    final search$ = textChangesS.doOnData((event) {
      currentPage.add(1);
    });

    final results$ = Rx.merge([refresh$, search$, loadMore$])
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
                  appendPhotos.addAll(data.hits as List<Hits>);
                  return Stream<PhotoState?>.value(PhotoLoaded(
                      data: appendPhotos,
                      currentPage: currentPage.value,
                      hasReachedMax: appendPhotos.length < data.totalHits));
                }))
            .startWith(const PhotoLoading())
            .onErrorReturnWith(
                (error, _) => const PhotoError("Đã có lỗi xảy ra"));
      }
    });
    return PhotoBloc._(
      search: textChangesS.sink,
      onLoadMore: loadMoreS,
      onRefresh: refreshS,
      results$: results$,
      dispose: () {
        textChangesS.close();
        currentPage.close();
        loadMoreS.close();
        refreshS.close();
      },
    );
  }

  PhotoBloc._({
    required this.search,
    required this.onRefresh,
    required this.onLoadMore,
    required this.results$,
    required this.dispose,
  });
}

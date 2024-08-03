import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/common/debug_stream.dart';

import 'package:rxdart/rxdart.dart';

import 'package:flutter_clean_architecture/domain/entities/photo/photo.dart';
import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/common/base/base_view_model.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class Input {
  final BehaviorSubject<String> search;
  final BehaviorSubject<void> onLoadMore;
  final BehaviorSubject<void> onRefresh;

  Input({
    required this.search,
    required this.onLoadMore,
    required this.onRefresh,
  });
}

class Output {
  final Stream<PhotoState?> results$;
  final Function0<void> dispose;

  Output({
    required this.results$,
    required this.dispose,
  });
}

class PhotoViewModel extends BaseViewModel<Input, Output> {
  final GetPhotoUseCase getPhoto;

  PhotoViewModel(this.getPhoto);

  @override
  Output transform(Input input) {
    final currentPage = BehaviorSubject<int>.seeded(1);
    final List<Hits> appendPhotos = [];

    final loadMore$ = input.onLoadMore.doOnData((event) {
      var nextPage = currentPage.value + 1;
      currentPage.add(nextPage);
    }).withLatestFrom(input.search, (_, s) => input.search.value);

    final refresh$ = input.onRefresh.doOnData((event) {
      currentPage.add(1);
    }).withLatestFrom(input.search, (_, s) => input.search.value);

    final search$ = input.search.doOnData((event) {
      currentPage.add(1);
    });

    final results$ = Rx.merge([refresh$, search$, loadMore$])
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap((String keyword) {
      if (keyword.isEmpty) {
        return Stream.value(null);
      } else {
        if (currentPage.value == 1) {
          const PhotoLoading();
        }
        return Stream.fromFuture(getPhoto
                .execute(RequestPhoto(query: keyword, page: currentPage.value)))
            .exhaustMap((either) => either.fold((error) {
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
            .debug()
            .onErrorReturnWith(
                (error, _) => const PhotoError("Đã có lỗi xảy ra"));
      }
    });

    return Output(
        results$: results$,
        dispose: () {
          input.search.close();
          input.onLoadMore.close();
          input.onRefresh.close();
          currentPage.close();
        });
  }
}

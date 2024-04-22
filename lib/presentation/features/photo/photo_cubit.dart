import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_architecture/domain/usecases/photo/get_photo_usecase.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Input
  final Sink<String?> search;
  final Function0<void> dispose;
  final Function0<void> loadMore;

  /// Output
  final Stream<PhotoState?> results$;

  factory PhotoCubit(final GetPhotoUseCase getPhoto) {
    final currentPage = BehaviorSubject<int>.seeded(1);
    final loadMore = BehaviorSubject<void>();
    final textChangesS = BehaviorSubject<String>();

    final loadMore$ = loadMore.doOnData((event) {
      var nextPage = currentPage.value + 1;
      currentPage.add(nextPage);
    }).withLatestFrom(textChangesS, (_, s) => textChangesS.value);

    final search$ = textChangesS.doOnData((event) {
      currentPage.add(1);
    });

    final results = Rx.merge([search$, loadMore$])
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap((String keyword) {
      if (keyword.isEmpty) {
        return Stream.value(null);
      } else {
        return Stream.fromFuture(getPhoto.execute(keyword))
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
    print('search : ${search$} - ${loadMore$}');

    return PhotoCubit._(
      search: textChangesS.sink,
      loadMore: () => loadMore.add(null),
      results$: results,
      dispose: () {
        textChangesS.close();
        currentPage.close();
        loadMore.close();
      },
    );
  }

  PhotoCubit._({
    required this.search,
    required this.loadMore,
    required this.results$,
    required this.dispose,
  }) : super(const PhotoInitial());
}

import 'package:rxdart/rxdart.dart';

import 'package:flutter_clean_architecture/presentation/features/photo/photo_view_model.dart';

class PhotoViewAdapter {
  /// Input
  final Input input;

  /// Output
  final Output output;

  factory PhotoViewAdapter(final PhotoViewModel photoViewModel) {
    final loadMoreS = BehaviorSubject<void>();
    final refreshS = BehaviorSubject<void>();
    final textChangesS = BehaviorSubject<String>();

    var input = Input(
      search: textChangesS,
      onLoadMore: loadMoreS,
      onRefresh: refreshS,
    );
    var output = photoViewModel.transform(input);

    return PhotoViewAdapter._(
      input: input,
      output: output,
    );
  }

  PhotoViewAdapter._({
    required this.input,
    required this.output,
  });
}

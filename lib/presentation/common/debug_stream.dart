import 'package:rxdart/rxdart.dart';

extension DebugStream<T> on Stream<T> {
  Stream<T> debug() {
    return doOnData((data) => print('===>>> Data: $data'))
        .doOnError((error, stackTrace) => print('===>>> Error: $error'))
        .doOnDone(() => {});
  }
}

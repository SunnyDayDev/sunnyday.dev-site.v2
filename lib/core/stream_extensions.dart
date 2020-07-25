
import 'package:rxdart/rxdart.dart';

extension StreamExtension<T> on Stream<T> {

  Stream<T> startWith(T item) {
    return Rx.concat([
      Stream.value(item),
      this
    ]);
  }

}
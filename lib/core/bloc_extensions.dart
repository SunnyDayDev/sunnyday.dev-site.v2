
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunnydaydev_site/core/stream_extensions.dart';

extension BlocExtension<E, S> on Bloc<E, S> {

  Stream<S> get stateStream => startWith(state);

}
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  bool get isLoading => this is AsyncLoading<T>;
  bool get isError => this is AsyncError<T>;
  bool get isData => this is AsyncData<T>;
}

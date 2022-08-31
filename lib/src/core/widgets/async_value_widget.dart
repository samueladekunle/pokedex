import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace?)? error;
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: error ?? (e, st) => Container(),
      loading: loading ?? () => Container(),
    );
  }
}

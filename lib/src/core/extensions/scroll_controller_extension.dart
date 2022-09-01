import 'package:flutter/material.dart';

extension ScrollControllerX on ScrollController {
  bool get isEndOfList => position.pixels >= position.maxScrollExtent + 100;
}

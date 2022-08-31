import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/src/theme/color_scheme.dart';

extension BuildContextX on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();

  double get width => getWidth();

  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> push<T>(Widget page) => Navigator.push<T>(
        this,
        MaterialPageRoute(builder: (context) => page),
      );

  PokedexColorScheme get colorScheme =>
      Theme.of(this).extension<PokedexColorScheme>()!;

  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

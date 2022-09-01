import 'package:flutter/material.dart';
import 'package:pokedex/src/theme/colors.dart';

@immutable
class PokedexColorScheme extends ThemeExtension<PokedexColorScheme> {
  final Color? primaryColor;
  final Color? scaffoldBackgroundColor;
  final Color? lightTextColor;
  final Color? darkTextColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? lowStatIndicatorColor;
  final Color? mediumStatIndicatorColor;
  final Color? highStateIndicatorColor;

  const PokedexColorScheme({
    required this.primaryColor,
    required this.scaffoldBackgroundColor,
    required this.lightTextColor,
    required this.darkTextColor,
    required this.selectedLabelColor,
    required this.unselectedLabelColor,
    required this.lowStatIndicatorColor,
    required this.mediumStatIndicatorColor,
    required this.highStateIndicatorColor,
  });

  @override
  PokedexColorScheme copyWith({
    Color? primaryColor,
    Color? scaffoldBackgroundColor,
    Color? darkTextColor,
    Color? highStateIndicatorColor,
    Color? lightTextColor,
    Color? lowStatIndicatorColor,
    Color? mediumStatIndicatorColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
  }) {
    return PokedexColorScheme(
      primaryColor: primaryColor ?? this.primaryColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      darkTextColor: darkTextColor ?? this.darkTextColor,
      highStateIndicatorColor:
          highStateIndicatorColor ?? this.highStateIndicatorColor,
      lightTextColor: lightTextColor ?? this.lightTextColor,
      lowStatIndicatorColor:
          lowStatIndicatorColor ?? this.lowStatIndicatorColor,
      mediumStatIndicatorColor:
          mediumStatIndicatorColor ?? this.mediumStatIndicatorColor,
      selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
    );
  }

  @override
  ThemeExtension<PokedexColorScheme> lerp(
      ThemeExtension<PokedexColorScheme>? other, double t) {
    if (other is! PokedexColorScheme) {
      return this;
    }

    return PokedexColorScheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      scaffoldBackgroundColor:
          Color.lerp(scaffoldBackgroundColor, other.scaffoldBackgroundColor, t),
      lightTextColor: Color.lerp(lightTextColor, other.lightTextColor, t),
      lowStatIndicatorColor:
          Color.lerp(lowStatIndicatorColor, other.lowStatIndicatorColor, t),
      mediumStatIndicatorColor: Color.lerp(
          mediumStatIndicatorColor, other.mediumStatIndicatorColor, t),
      selectedLabelColor:
          Color.lerp(selectedLabelColor, other.selectedLabelColor, t),
      unselectedLabelColor:
          Color.lerp(unselectedLabelColor, other.unselectedLabelColor, t),
      darkTextColor: Color.lerp(darkTextColor, other.darkTextColor, t),
      highStateIndicatorColor:
          Color.lerp(highStateIndicatorColor, other.highStateIndicatorColor, t),
    );
  }

  static get light => const PokedexColorScheme(
        primaryColor: PokedexColorLight.primaryColor,
        scaffoldBackgroundColor: PokedexColorLight.scaffoldBackgroundColor,
        darkTextColor: PokedexColorLight.darkTextColor,
        highStateIndicatorColor: PokedexColorLight.highStateIndicatorColor,
        lightTextColor: PokedexColorLight.lightTextColor,
        lowStatIndicatorColor: PokedexColorLight.lowStatIndicatorColor,
        mediumStatIndicatorColor: PokedexColorLight.mediumStatIndicatorColor,
        selectedLabelColor: PokedexColorLight.selectedLabelColor,
        unselectedLabelColor: PokedexColorLight.unselectedLabelColor,
      );
}

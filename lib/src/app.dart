import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokedex/gen/fonts.gen.dart';
import 'package:pokedex/src/features/pokemon/presentation/pages/pokemon_home_page.dart';
import 'package:pokedex/src/theme/color_scheme.dart';
import 'package:pokedex/src/theme/colors.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        fontFamily: FontFamily.notoSans,
        scaffoldBackgroundColor: PokedexColorLight.scaffoldBackgroundColor,
      ).copyWith(
        extensions: [
          PokedexColorScheme.light,
        ],
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case PokemonHomePage.routeName:
              default:
                return const PokemonHomePage();
            }
          },
        );
      },
    );
  }
}

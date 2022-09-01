import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/favourite_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/pages/tabs/all_pokemon_tab.dart';
import 'package:pokedex/src/features/pokemon/presentation/pages/tabs/favourite_pokemon_tab.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_home_app_bar.dart';

class PokemonHomePage extends ConsumerStatefulWidget {
  const PokemonHomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  ConsumerState<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends ConsumerState<PokemonHomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(fetchPokemonNotifierProvider.notifier).fetchPokemonList();
    ref.read(favouritePokemonNotifierProvider.notifier).watchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PokemonHomeAppBar(),
        body: TabBarView(
          children: [
            AllPokemonTab(),
            FavouritePokemonTab(),
          ],
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.white,
    //       centerTitle: true,
    //       title: Assets.images.appLogo.image(
    //         fit: BoxFit.contain,
    //         height: 32,
    //       ),
    //     ),
    //     body: Column(
    //       children: const [
    //         PokemonHomeTabBar(),
    //         Expanded(
    //           child: TabBarView(
    //             children: [
    //               AllPokemonTab(),
    //               FavouritePokemonTab(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

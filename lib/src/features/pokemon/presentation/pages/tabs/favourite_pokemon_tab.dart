import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/favourite_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_list_grid.dart';

class FavouritePokemonTab extends ConsumerStatefulWidget {
  const FavouritePokemonTab({Key? key}) : super(key: key);

  @override
  ConsumerState<FavouritePokemonTab> createState() =>
      _FavouritePokemonTabState();
}

class _FavouritePokemonTabState extends ConsumerState<FavouritePokemonTab>
    with AutomaticKeepAliveClientMixin<FavouritePokemonTab> {
  final tabKey = const PageStorageKey('favourite_pokemon_tab');

  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(favouritePokemonNotifierProvider).pokemonList;

    if (pokemonList.isNotEmpty) {
      return PokemonListGrid(
        scrollController: _scrollController,
        pokemonList: pokemonList,
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          context.localizations.noFavouritePokemonFoundMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

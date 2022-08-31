import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/config/constants.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/extensions/pokemon_extensions.dart';
import 'package:pokedex/src/core/extensions/string_extensions.dart';
import 'package:pokedex/src/core/widgets/image.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/pages/pokemon_detail_page.dart';

class PokemonListGrid extends StatelessWidget {
  const PokemonListGrid({
    Key? key,
    required this.scrollController,
    required this.pokemonList,
  }) : super(key: key);

  final PokemonList pokemonList;
  final ScrollController scrollController;

  final tabKey = const PageStorageKey('all_pokemon_tab');

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: tabKey,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Insets.sm),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: kMaxGridExtent,
        mainAxisSpacing: Insets.sm,
        crossAxisSpacing: Insets.sm,
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];

        return PokemonGridItem(
          pokemon: pokemon,
        );
      },
    );
  }
}

class PokemonGridItem extends ConsumerWidget {
  const PokemonGridItem({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () {
        ref
            .read(fetchPokemonNotifierProvider.notifier)
            .fetchPokemon(pokemon.id.toInt());
        context.push(PokemonDetailPage(pokemon: pokemon));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Insets.xs),
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Hero(
              tag: ValueKey(pokemon.id),
              child: HostedImage(
                url: pokemon.imageUrl,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pokemon.pokedexId,
                    style: TextStyle(
                      color: colorScheme.darkTextColor,
                    ),
                  ),
                  Text(
                    pokemon.name.capitalize(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/extensions/pokemon_extensions.dart';
import 'package:pokedex/src/core/widgets/fab_extended_button.dart';
import 'package:pokedex/src/core/widgets/gap.dart';
import 'package:pokedex/src/core/widgets/indicator.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/domain/resource.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/favourite_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_detail_app_bar.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_detail_header_delegate.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_detail_stat_tile.dart';
import 'package:pokedex/src/theme/colors.dart';

class PokemonDetailPage extends ConsumerStatefulWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  static const routeName = '/pokemon';

  final Pokemon pokemon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonDetailPageState();
}

class _PokemonDetailPageState extends ConsumerState<PokemonDetailPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchPokemon = ref.watch(fetchPokemonNotifierProvider);
    final pokemon =
        fetchPokemon.pokemon.isEmpty ? widget.pokemon : fetchPokemon.pokemon;

    final isFavourite = ref
        .watch(favouritePokemonNotifierProvider)
        .pokemonList
        .isFavourite(pokemon);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          PokemonDetailAppBar(
            pokemon: pokemon,
            isExpanded: _scrollController.hasClients &&
                _scrollController.offset > (200 - kToolbarHeight),
          ),
          SliverPersistentHeader(
            delegate: PokemonDetailHeaderDelegate(
              pokemon: pokemon,
            ),
            pinned: true,
          ),
          if (fetchPokemon.status.isLoading) ...[
            const SliverFillRemaining(
              child: LoadingIndicator(),
            ),
          ] else
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(Insets.md),
                      child: Text(
                        context.localizations.baseStats,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.darkTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const VGap(0.5),
                  ...pokemon.stats.map((stat) => PokemonDetailStatTile(
                        stat: stat,
                      )),
                  const PokemonDetailStatTile(
                    stat: PokemonStat(
                      baseStat: 0,
                      effort: 0,
                      stat: Resource(url: '', name: 'Avg. Power'),
                    ),
                  ),
                  const VGap(120),
                ],
              ),
            )
        ],
        // ],
      ),
      floatingActionButton: FloatingActionButtonExtended(
        backgroundColor: isFavourite
            ? PokedexColorLight.lightButtonColor
            : context.colorScheme.primaryColor,
        onPressed: () {
          if (isFavourite) {
            ref
                .read(favouritePokemonNotifierProvider.notifier)
                .deletePokemn(pokemon.id);
          } else {
            ref
                .read(favouritePokemonNotifierProvider.notifier)
                .savePokemon(pokemon);
          }
        },
        label: isFavourite
            ? context.localizations.removeFromFavouritesLabel
            : context.localizations.markAsFavouriteButtonLabel,
        labelColor:
            isFavourite ? context.colorScheme.primaryColor : Colors.white,
      ),
    );
  }
}

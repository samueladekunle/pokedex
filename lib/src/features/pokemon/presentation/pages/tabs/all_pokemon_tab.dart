import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/core/extensions/scroll_controller_extension.dart';
import 'package:pokedex/src/core/widgets/app_exception_widget.dart';
import 'package:pokedex/src/core/widgets/indicator.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/pokemon_list_grid.dart';

class AllPokemonTab extends ConsumerStatefulWidget {
  const AllPokemonTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllPokemonTabState();
}

class _AllPokemonTabState extends ConsumerState<AllPokemonTab> {
  final _scrollController = ScrollController();

  void _paginate() {
    if (_scrollController.isEndOfList) {
      ref.read(fetchPokemonNotifierProvider.notifier).fetchNextPokemonList();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_paginate);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_paginate);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchPokemon = ref.watch(fetchPokemonNotifierProvider);

    if (fetchPokemon.pokemonList.isNotEmpty) {
      return PokemonListGrid(
        scrollController: _scrollController,
        pokemonList: fetchPokemon.pokemonList,
      );
    }

    if (fetchPokemon.status.isError && fetchPokemon.exception != null) {
      return AppExceptionWidget(
        exception: fetchPokemon.exception!,
        onRetry: ref
            .read(fetchPokemonNotifierProvider.notifier)
            .fetchNextPokemonList,
      );
    }

    return const LoadingIndicator();
  }
}

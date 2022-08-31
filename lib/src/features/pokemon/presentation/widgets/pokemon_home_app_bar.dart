import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/gen/assets.gen.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/widgets/gap.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/favourite_pokemon_notifier.dart';

class PokemonHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokemonHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Assets.images.appLogo.image(
        fit: BoxFit.contain,
        height: 32,
      ),
      bottom: const _AppBarTab(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}

class _AppBarTab extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarTab({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: colorScheme.scaffoldBackgroundColor!,
          ),
        ),
      ),
      child: TabBar(
        unselectedLabelColor: colorScheme.unselectedLabelColor,
        labelColor: colorScheme.selectedLabelColor,
        indicatorColor: colorScheme.primaryColor,
        labelPadding: const EdgeInsets.symmetric(vertical: Insets.xs),
        indicatorWeight: 3,
        tabs: [
          Tab(
            child: Text(
              context.localizations.allPokemonsTabTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Tab(
            child: Consumer(
              builder: (context, ref, child) {
                final favouriteCount = ref
                    .watch(favouritePokemonNotifierProvider)
                    .pokemonList
                    .length;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.localizations.favouritePokemonsTabTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    if (favouriteCount > 0) ...[
                      const HGap(
                        Insets.xs,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primaryColor,
                        ),
                        padding: const EdgeInsets.all(Insets.xs),
                        child: Text(
                          '$favouriteCount',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

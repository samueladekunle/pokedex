import 'package:flutter/material.dart';
import 'package:pokedex/gen/assets.gen.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/extensions/pokemon_extensions.dart';
import 'package:pokedex/src/core/extensions/string_extensions.dart';
import 'package:pokedex/src/core/widgets/image.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

class PokemonDetailAppBar extends StatelessWidget {
  const PokemonDetailAppBar({
    super.key,
    required this.pokemon,
    this.isExpanded = true,
  });

  final Pokemon pokemon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: const Icon(
          Icons.chevron_left,
          size: 30,
          color: Colors.black,
        ),
      ),
      pinned: true,
      elevation: 0,
      expandedHeight: 220,
      backgroundColor:
          isExpanded ? pokemon.color : pokemon.color.withOpacity(0.1),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(
          left: Insets.md,
          bottom: Insets.md,
        ),
        title: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
            left: isExpanded ? 32 : 0,
            bottom: 3,
          ),
          child: Text(
            pokemon.pokedexId,
            style: TextStyle(
              color: context.colorScheme.darkTextColor,
              fontSize: isExpanded ? 15 : 12,
            ),
          ),
        ),
        background: _AppBarBackground(pokemon: pokemon),
      ),
    );
  }
}

class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: -Insets.md,
          child: Assets.images.pokedex.image(
            fit: BoxFit.contain,
            height: 200,
            color: pokemon.color,
          ),
        ),
        Positioned(
          right: 24,
          child: Hero(
            tag: ValueKey(pokemon.id),
            child: HostedImage(
              url: pokemon.imageUrl,
              height: 170,
            ),
          ),
        ),
        Positioned(
          left: Insets.md,
          top: kToolbarHeight * 2,
          right: context.getWidth(0.5),
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pokemon.name.capitalize(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // color: AppColors.textPrimaryColor,
                  color: context.colorScheme.darkTextColor,
                  fontSize: 27,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pokemon.types
                    .map((type) => type.type.name.capitalize())
                    .join(", "),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

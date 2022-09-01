import 'package:flutter/material.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/extensions/pokemon_extensions.dart';
import 'package:pokedex/src/core/widgets/gap.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

class PokemonDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PokemonDetailHeaderDelegate({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colorScheme = context.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.scaffoldBackgroundColor!,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          _HeaderItemTitle(
            title: context.localizations.height,
            value: "${pokemon.height}",
          ),
          _HeaderItemTitle(
            title: context.localizations.weight,
            value: "${pokemon.weight}",
          ),
          _HeaderItemTitle(
            title: context.localizations.bmi,
            value: pokemon.bmi.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 78;

  @override
  double get minExtent => 78;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;
}

class _HeaderItemTitle extends StatelessWidget {
  const _HeaderItemTitle({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.darkTextColor,
            ),
          ),
          const VGap(Insets.xs),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

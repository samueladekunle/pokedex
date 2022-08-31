import 'package:flutter/material.dart';
import 'package:pokedex/src/config/insets.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';
import 'package:pokedex/src/core/extensions/num_extensions.dart';
import 'package:pokedex/src/core/extensions/string_extensions.dart';
import 'package:pokedex/src/core/widgets/gap.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

class PokemonDetailStatTile extends StatefulWidget {
  const PokemonDetailStatTile({super.key, required this.stat});

  final PokemonStat stat;

  @override
  State<PokemonDetailStatTile> createState() => _PokemonDetailStatTileState();
}

class _PokemonDetailStatTileState extends State<PokemonDetailStatTile>
    with SingleTickerProviderStateMixin<PokemonDetailStatTile> {
  late AnimationController controller;
  late Animation<double> animation;
  late PokemonStat stat;
  late double value;

  Color get color {
    final value = animation.value;
    if (value > 0.7) {
      return context.colorScheme.highStateIndicatorColor!;
    } else if (value > 0.3) {
      return context.colorScheme.mediumStatIndicatorColor!;
    } else {
      return context.colorScheme.lowStatIndicatorColor!;
    }
  }

  @override
  void initState() {
    super.initState();
    stat = widget.stat;
    value = stat.baseStat.lerp(0, 100, upperBound: 1);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    animation = Tween<double>(begin: 0, end: value).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Insets.md),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                stat.stat.name.replaceAll("-", " ").toTitleCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: context.colorScheme.lightTextColor,
                ),
              ),
              const HGap(Insets.sm),
              Text(
                stat.baseStat.toString(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const VGap(Insets.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(Insets.xs),
            child: LinearProgressIndicator(
              value: animation.value,
              backgroundColor: const Color(0xffE8E8E8),
              valueColor: AlwaysStoppedAnimation<Color>(
                color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
    super.key,
    this.pokemonDetail,
    required this.clr,
    required this.heroTag,
  });

  final pokemonDetail;
  final Color clr;
  final int heroTag;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: widget.clr);
  }
}

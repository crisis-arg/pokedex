import 'package:cached_network_image/cached_network_image.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.clr,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.08,
            left: 30,
            child: Text(
              widget.pokemonDetail['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: 30,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Text(
                      widget.pokemonDetail['type'][0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (widget.pokemonDetail['type'].length > 1) SizedBox(width: 5),
                if (widget.pokemonDetail['type'].length > 1)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 4,
                        bottom: 4,
                      ),
                      child: Text(
                        widget.pokemonDetail['type'][1],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Positioned(
            top: height * 0.16,
            right: -10,
            child: Image.asset(
              'images/pokeball.png',
              height: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.2,
            left: width * 0.2,
            child: CachedNetworkImage(
              imageUrl: widget.pokemonDetail['img'],
              height: height * 0.3,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}

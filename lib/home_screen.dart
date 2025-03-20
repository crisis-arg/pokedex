import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeapi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  List pokedex = [];

  @override
  void initState() {
    if (mounted) {
      fetchpokemondata();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          pokedex.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: pokedex.length,
                      itemBuilder: (context, index) {
                        var type = pokedex[index]['type'][0];
                        return Card(
                          color: Colors.green,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: Image.asset(
                                  'images/pokeball.png',
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 5,
                                child: Text(
                                  pokedex[index]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 35,
                                left: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: Colors.black26,
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: Text(
                                      type.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 5,
                                child: CachedNetworkImage(
                                  imageUrl: (pokedex[index]['img'] as String)
                                      .replaceFirst("http", "https"),
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  void fetchpokemondata() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "/Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );

    await http.get(url).then((onValue) {
      if (onValue.statusCode == 200) {
        var decodedjsondata = jsonDecode(onValue.body);
        // print(decodedjsondata);
        pokedex = decodedjsondata['pokemon'];
        print(pokedex[0]['name']);
        setState(() {});
      }
    });
  }
}

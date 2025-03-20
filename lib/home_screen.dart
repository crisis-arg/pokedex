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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          pokedex.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -50,
                      child: Image.asset(
                        'images/pokeball.png',
                        width: width * 0.6,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Text(
                        'Pokedex',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: pokedex.length,
                        itemBuilder: (context, index) {
                          var type = pokedex[index]['type'][0];
                          return Container(
                            decoration: BoxDecoration(
                              color:
                                  type == 'Grass'
                                      ? Colors.greenAccent
                                      : type == 'Fire'
                                      ? Colors.redAccent
                                      : type == 'Bug'
                                      ? Colors.green
                                      : type == 'Electric'
                                      ? const Color.fromARGB(255, 204, 188, 41)
                                      : type == 'Poison'
                                      ? Colors.deepPurpleAccent
                                      : type == 'Water'
                                      ? Colors.lightBlueAccent
                                      : type == 'Ground'
                                      ? const Color.fromARGB(255, 72, 36, 23)
                                      : type == 'Fighting'
                                      ? Colors.orangeAccent
                                      : type == 'Psychic'
                                      ? const Color.fromARGB(255, 210, 44, 100)
                                      : type == 'Rock'
                                      ? Colors.brown
                                      : type == 'Dragon'
                                      ? Colors.blue
                                      : Colors.pinkAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: Image.asset(
                                    'images/pokeball.png',
                                    height: height * 0.13,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Positioned(
                                  bottom: 3,
                                  right: 5,
                                  child: CachedNetworkImage(
                                    imageUrl: (pokedex[index]['img'] as String)
                                        .replaceFirst("http", "https"),
                                    height: height * 0.1,
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
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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

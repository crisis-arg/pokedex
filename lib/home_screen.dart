import 'dart:convert';

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
      backgroundColor: Colors.amber,
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
                        return Card(child: Text(pokedex[index]['name']));
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

import 'package:flutter/material.dart';
import 'package:pokedex/home_screen.dart';

void main() {
  runApp(const Pokedex());
}


class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
    );
  }
}

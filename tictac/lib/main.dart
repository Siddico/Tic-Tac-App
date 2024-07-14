import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictac/constants.dart';
import 'package:tictac/homepage/home_screen.dart';

void main() {
  runApp(const TicTac());
}

class TicTac extends StatelessWidget {
  const TicTac({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: styles.KPrimaryColor,
          textTheme: GoogleFonts.cairoTextTheme().copyWith()),
      home: const HomeScreen(),
    );
  }
}

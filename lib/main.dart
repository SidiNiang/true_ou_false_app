import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      home: const MyHomePage(title: 'True ou False'),
      theme: ThemeData(fontFamily: "Montserrat"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int leftDiceButton = 4;
  int rightDiceButton = 6;

  var random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF443f39),
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF443f39)),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ligne des dés
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20),
                        child: const Text("Question 1",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Ligne des Boutons Vrai ou Faux
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              50), // Ajoute un padding de 16 pixels sur les côtés
                    ),
                    onPressed: () {
                      log("Left button pressed");
                      log("$rightDiceButton");
                    },
                    child: const Text("VRAI",
                        style: TextStyle(
                            color: Color(0xFF443f39),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              50), // Ajoute un padding de 16 pixels sur les côtés
                    ),
                    onPressed: () {
                      log("Right button pressed");
                      log("$rightDiceButton");
                    },
                    child: const Text("FAUX",
                        style: TextStyle(
                            color: Color(0xFF443f39),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}

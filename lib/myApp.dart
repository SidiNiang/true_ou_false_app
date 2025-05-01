import 'dart:convert';
import 'dart:core' as api;
import 'dart:core';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/models/question.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});

  final String title;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int leftDiceButton = 4;
  int rightDiceButton = 6;

  var random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 247, 252),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 221, 0, 255),
          title: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 252, 247, 252)),
          ),
        ),
        body: FutureBuilder<List<Question>>(
            future: getQuestion(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitCubeGrid(
                  color: Colors.white,
                  size: 50.00,
                ));
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erreur : ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ));
              } else {
                final questions = snapshot.data;
                var i = 0;

                return SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(25),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    DefaultTextStyle(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Question $i"),
                                            const SizedBox(height: 10),
                                            Text(
                                                "Difficulte : ${questions?[i].difficulte}"
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            Text("${questions?[i].question}"),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () => true,
                                child: const Text("VRAI",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () => false,
                                child: const Text("FAUX",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ));
              }
            }));
  }
}

Future<List<Question>> getQuestion() async {
  final response = await http.get(Uri.parse(
      "https://opentdb.com/api.php?amount=10&category=18&type=boolean"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final List questionJson = data['results'];

    return questionJson.map((json) => Question.fromJson(json)).toList();
  } else {
    throw Exception("Erreur de chargement des questions");
  }
}

        // SafeArea(
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         // Ligne des dés
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Container(
        //                 alignment: Alignment.center,
        //                 color: Colors.white,
        //                 padding: const EdgeInsets.symmetric(vertical: 150),
        //                 child: const Text("Question 1 \n Est ce que la Terre est Ronde ?",
        //                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        //                     textAlign: TextAlign.center,),
        //               ),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: 20),
        //         // Ligne des Boutons Vrai ou Faux
        //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //           ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal:
        //                       50), // Ajoute un padding de 16 pixels sur les côtés
        //             ),
        //             onPressed: () {
        //               log("Left button pressed");
        //               log("$rightDiceButton");
        //             },
        //             child: const Text("VRAI",
        //                 style: TextStyle(
        //                     color: Color(0xFF443f39),
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold)),
        //           ),
        //           const SizedBox(width: 20),
        //           ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal:
        //                       50), // Ajoute un padding de 16 pixels sur les côtés
        //             ),
        //             onPressed: () {
        //               log("Right button pressed");
        //               log("$rightDiceButton");
        //             },
        //             child: const Text("FAUX",
        //                 style: TextStyle(
        //                     color: Color(0xFF443f39),
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold)),
        //           ),
        //         ]),
        //       ],
        //     ),
        //   ),
        // ));
        // }

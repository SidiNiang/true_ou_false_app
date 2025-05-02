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
  var random = math.Random();
  var i = 0;
  var score = 0;
  bool quizTermine = false;
  List<Question> questions =
      []; // Déclarer une variable pour stocker les questions
  bool loading =
      true; // Indicateur pour savoir si les questions sont encore en cours de chargement

  @override
  void initState() {
    super.initState();
    getQuestions(); // Appeler la méthode pour charger les questions
  }

  // Charger les questions à partir de l'API
  Future<void> getQuestions() async {
    try {
      final fetchedQuestions = await getQuestion();
      setState(() {
        questions = fetchedQuestions; // Mettre à jour la liste de questions
        loading = false; // Les questions sont chargées, donc on change l'état
      });
    } catch (e) {
      setState(() {
        loading = false; // Si erreur, on change aussi l'état
      });
      print('Erreur lors du chargement des questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 247, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 0, 255),
        leading: const Icon(Icons.quiz, color: Colors.white),
        titleSpacing: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 252, 247, 252)),
        ),
      ),
      body:
          loading // Vérifier si les questions sont toujours en train de se charger
              ? const Center(
                  child: SpinKitCubeGrid(
                    color: Color.fromARGB(255, 221, 0, 255),
                    size: 50.00,
                  ),
                )
              : quizTermine
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Quiz terminé !",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Votre score est $score/${questions.length}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                i = 0;
                                score = 0;
                                quizTermine = false;
                              });
                            },
                            child: const Text("Rejouer"),
                          )
                        ],
                      ),
                    )
                  : SafeArea(
                      child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(25),
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 221, 0, 255),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.blue,
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ),
                                    blurRadius: 7.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                ]),
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
                                              fontFamily: "Montserrat"),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Question ${i + 1}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "Niveau ${questions[i].difficulte}"
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 10),
                                              Text(questions[i].question),
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
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 220, 0, 0), // Couleur de fond
                                    foregroundColor:
                                        Colors.white, // Couleur du texte
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Coins arrondis
                                    ),
                                  ),
                                  onPressed: () => {
                                        print("btn vrai"),
                                        setState(() {
                                          if (questions[i].reponsecorrect ==
                                              true) {
                                            score = score + 1;
                                          }
                                          i++;
                                          if (i >= questions.length) {
                                            quizTermine = true;
                                          }
                                        })
                                      },
                                  child: const Text("VRAI",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.bold))),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // Couleur de fond
                                    foregroundColor:
                                        Colors.white, // Couleur du texte
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Coins arrondis
                                    ),
                                  ),
                                  onPressed: () => {
                                        print("btn faux"),
                                        setState(() {
                                          if (questions[i].reponsecorrect ==
                                              false) {
                                            score = score + 1;
                                          }
                                          i++;
                                          if (i >= questions.length) {
                                            quizTermine = true;
                                          }
                                        })
                                      },
                                  child: const Text("FAUX",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.bold))),
                            ],
                          )
                        ],
                      ),
                    )),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {}, // VISUEL
        backgroundColor: Colors.purple,
        child: Text(
          "Score $score/10",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
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

import 'dart:convert';
import 'dart:core' as api;
import 'dart:core';
import 'dart:developer';
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
        backgroundColor: const Color(0xFF443f39),
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),

        body: FutureBuilder<List<Question>>(
        future: getQuestion(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
             return const Center(
                  child: SpinKitCubeGrid(
                color: Colors.white,
                size: 50.00,
              ));
          }else if(snapshot.hasError){
            return Center (child: Text("Erreur : ${snapshot.hasError}"));
          }else{
            final questions = snapshot.data;

            return Scaffold();
          }
        }
        ));
}}
   
  Future <List<Question>> getQuestion() async{

    final response = await http.get(Uri.parse("https://opentdb.com/api.php?amount=10&category=18&type=boolean"));

    if(response.statusCode == 200){ 
      final data = jsonDecode(response.body);

      final List questionJson = data['results'];

      return questionJson.map((json) => Question.fromJson(json)).toList();
    }else{
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

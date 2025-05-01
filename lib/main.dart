import 'package:flutter/material.dart';
import 'package:flutter_app/MyApp.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      theme: ThemeData(fontFamily: "Montserrat"),
      home: const MyApp(title: 'Quizz App',),
  ));
}



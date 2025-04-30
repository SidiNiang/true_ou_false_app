class Question {

  final String difficulte;
  final bool reponsecorrect;
  final String question;

  Question({
    required this.difficulte,
    required this.reponsecorrect,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json){
    return Question(
      difficulte: json["results"]["difficulty"],
      reponsecorrect: json["results"]["correct_answer"],
      question: json["results"]["question"],
    );
  }

}

import 'package:flutter/material.dart';
import 'result.dart';
import 'quiz.dart';

main() => runApp(const QuestionApp());

class QuestionApp extends StatefulWidget {
  const QuestionApp({super.key});

  @override
  _QuestionAppState createState() {
    return _QuestionAppState();
  }
}

class _QuestionAppState extends State<QuestionApp> {
  var _questionSelected = 0;
  var _totalScore = 0;
  final _questions = const [
    {
      'text': "Qual é a sua cor favorita ?",
      'responses': [
        {'text': 'Preto', 'grade': 10},
        {'text': 'Vermelho', 'grade': 5},
        {'text': 'Verde', 'grade': 3},
        {'text': 'Branco', 'grade': 1},
      ]
    },
    {
      'text': "Qual é o seu animal favorito ?",
      'responses': [
        {'text': 'Coelho', 'grade': 10},
        {'text': 'Cobra', 'grade': 5},
        {'text': 'Elefante', 'grade': 3},
        {'text': 'Leão', 'grade': 1},
      ]
    },
    {
      'text': "Qual seu instrutor favorito ?",
      'responses': [
        {'text': 'Leo', 'grade': 10},
        {'text': 'Maria', 'grade': 5},
        {'text': 'João', 'grade': 3},
        {'text': 'Pedro', 'grade': 1},
      ]
    }
  ];

  bool get hasQuestionSelected {
    return _questionSelected < _questions.length;
  }

  void onAnswer(int score) {
    if (!hasQuestionSelected) {
      return;
    }
    setState(() {
      _questionSelected++;
      _totalScore += score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
        ),
        body: hasQuestionSelected
            ? Quiz(
                questionSelected: _questionSelected,
                questions: _questions,
                onAnswer: onAnswer,
              )
            : Result(_totalScore),
      ),
    );
  }
}

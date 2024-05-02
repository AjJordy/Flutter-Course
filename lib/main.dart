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
  final _questions = const [
    {
      'text': "Qual é a sua cor favorita ?",
      'responses': ['Preto', 'Vermelho', 'Verde', 'Branco']
    },
    {
      'text': "Qual é o seu animal favorito ?",
      'responses': ['Coelho', 'Cobra', 'Elefante', 'Leão']
    },
    {
      'text': "Qual seu instrutor favorito ?",
      'responses': ['Maria', 'João', 'Leo', 'Pedro']
    }
  ];

  bool get hasQuestionSelected {
    return _questionSelected < _questions.length;
  }

  void onAnswer() {
    if (!hasQuestionSelected) {
      return;
    }
    setState(() {
      _questionSelected++;
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
            : const Result(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'question.dart';
import 'response.dart';

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
  final questions = [
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

  void _responder() {
    setState(() {
      _questionSelected++;
      if (_questionSelected > questions.length - 1) {
        _questionSelected = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> responses = [];
    for (var textResp in questions[_questionSelected]['responses'] as List) {
      print(textResp);
      responses.add(Response(textResp, _responder));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
        ),
        body: Column(
          children: [
            Question(questions[_questionSelected]['text'] as String),
            ...responses,
          ],
        ),
      ),
    );
  }
}

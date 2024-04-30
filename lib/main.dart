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

  void _responder() {
    if (!hasQuestionSelected) {
      return;
    }
    setState(() {
      _questionSelected++;
    });
  }

  bool get hasQuestionSelected {
    return _questionSelected < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? responses = hasQuestionSelected
        ? _questions[_questionSelected]['responses'] as List<String>
        : null;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
        ),
        body: hasQuestionSelected
            ? Column(
                children: [
                  Question(_questions[_questionSelected]['text'] as String),
                  ...responses!.map((t) => Response(t, _responder)),
                ],
              )
            : const Center(
                child: Text(
                  'Parabéns',
                  style: TextStyle(fontSize: 28),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final void Function() restartQuiz;
  const Result(this.totalScore, this.restartQuiz, {super.key});

  String get resultText {
    if (totalScore < 8) {
      return 'Parabéns';
    } else if (totalScore < 12) {
      return 'Você é muito bom';
    } else if (totalScore < 16) {
      return 'Impressionante';
    } else {
      return 'Nível Jedi!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            resultText,
            style: const TextStyle(fontSize: 28),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: restartQuiz,
            child: const Text(
              'Reiniciar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}

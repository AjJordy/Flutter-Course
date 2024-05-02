import 'package:flutter/material.dart';
import 'question.dart';
import 'response.dart';

class Quiz extends StatelessWidget {
  final int questionSelected;
  final List<Map<String, Object>> questions;
  final void Function() onAnswer;

  const Quiz({
    super.key,
    required this.questions,
    required this.questionSelected,
    required this.onAnswer,
  });

  bool get hasQuestionSelected {
    return questionSelected < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? responses = hasQuestionSelected
        ? questions[questionSelected]['responses'] as List<String>
        : null;

    return Column(
      children: [
        Question(questions[questionSelected]['text'] as String),
        ...responses!.map((t) => Response(t, onAnswer)),
      ],
    );
  }
}

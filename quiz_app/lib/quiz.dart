import 'package:flutter/material.dart';
import 'question.dart';
import 'response.dart';

class Quiz extends StatelessWidget {
  final int questionSelected;
  final List<Map<String, Object>> questions;
  final void Function(int) onAnswer;

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
    List<Map<String, Object>>? responses = hasQuestionSelected
        ? questions[questionSelected]['responses'] as List<Map<String, Object>>
        : null;

    return Column(
      children: [
        Question(questions[questionSelected]['text'] as String),
        ...responses!.map(
          (resp) => Response(
            resp['text'] as String,
            () => onAnswer(resp['grade'] as int),
          ),
        ),
      ],
    );
  }
}

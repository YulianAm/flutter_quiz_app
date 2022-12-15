import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  static final routeName = "/quiz";

  final List<Map<String, Object>> questions;
  final int questionIndex;
  final int totalScore;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
    @required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    var userEmail = ModalRoute.of(context).settings.arguments;

    return questionIndex >= questions.length
        ? Text('No More Questions')
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 138, 167, 255),
                    Color.fromARGB(255, 80, 220, 255),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('user: $userEmail'),
                Question(
                  questions[questionIndex]['questionText'],
                ),
                ...(questions[questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return Answer(() => answerQuestion(answer['score'], context),
                      answer['text']);
                }).toList(),
                Text(
                  'Total Score so far is:    $totalScore',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                )
              ],
            ),
          );
  }
}

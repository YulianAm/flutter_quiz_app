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

    //LOP user email to DB

    return questionIndex >= questions.length
        ? Text('No More Questions')
        : Column(
            children: [
              Question(
                questions[questionIndex]['questionText'],
              ),
              ...(questions[questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map((answer) {
                return Answer(() => answerQuestion(answer['score'], context),
                    answer['text']);
              }).toList(),
              Text('Total Score so far is: $totalScore')
            ],
          );
  }
}

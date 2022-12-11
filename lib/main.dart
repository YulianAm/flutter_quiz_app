import 'package:first_app/db/questions_database.dart';
import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';
import 'models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

Future createUserLog() async {
  try {
    var user =
        QuestionsDatabase().create(new User(1213131, 'Yulian', DateTime.now()));

    var userGet = await QuestionsDatabase().get(1213131);

    print(user);
  } catch (e) {
    new Exception();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color ?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite actor?',
      'answers': [
        {'text': 'Brad Pit', 'score': 1},
        {'text': 'Tom Hardy', 'score': 3},
        {'text': 'Jennifer Aniston', 'score': 5},
        {'text': 'Leonardo DeCaprio', 'score': 4},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      var user = createUserLog();
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      var user = createUserLog();
      print(user);
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                totalScore: _totalScore,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}

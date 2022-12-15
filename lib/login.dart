import 'dart:math';

import 'package:first_app/quiz.dart';
import 'package:flutter/material.dart';

import 'db/questions_database.dart';
import 'models/User.dart';

class Login extends StatelessWidget {
  bool isLogged = false;
  TextEditingController _controllerUserEmail = TextEditingController();

  Future createUserLog() async {
    var random = new Random().nextInt(100);

    if (!isLogged) {
      try {
        var user = QuestionsDatabase().create(
            new User(random, _controllerUserEmail.text, DateTime.now()));

        user = QuestionsDatabase().get(random);

        print("user $user is logged!");

        isLogged = true;
      } catch (e) {
        new Exception();
      }
    }
  }

  void loginAndNavigate(BuildContext context) {
    Navigator.of(context)
        .pushNamed(Quiz.routeName, arguments: _controllerUserEmail.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Quiz App',
          style: TextStyle(
              fontSize: 36,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
              backgroundColor: Color.fromARGB(149, 156, 230, 243)),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email input field
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _controllerUserEmail,
                decoration: InputDecoration(
                    hintText: 'Enter your email',
                    fillColor: Colors.blue,
                    hintTextDirection: TextDirection.ltr),
              ),
              // Password input field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  fillColor: Colors.blue,
                ),
              ),
              // Login button
              ElevatedButton(
                  child: Text('Login'),
                  onPressed: () => loginAndNavigate(context)),
            ],
          ),
        ),
      ],
    );
  }
}

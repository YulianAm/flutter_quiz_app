import 'package:first_app/quiz.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Map<String, String> args = {'userEmail': 'empty'};

  TextEditingController _controllerUserEmail = TextEditingController();

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
                onPressed: () {
                  Navigator.of(context).pushNamed(Quiz.routeName,
                      arguments: _controllerUserEmail.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

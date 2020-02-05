import 'package:flutter/material.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;

  const TriviaDisplay({
    Key key,
    this.trivia,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Fixed size, doesn't scroll
        Text(
          trivia.number.toString(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Expanded makes it fill in all the remaining space
        Expanded(
          child: Center(
            // Only the trivia "message" part will be scrollable
            child: SingleChildScrollView(
              child: Text(
                trivia.text,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
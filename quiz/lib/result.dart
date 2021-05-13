import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 20)
      resultText = "Schlecht! Deine Punktzahl: ${resultScore.toString()}";
    else if (resultScore <= 30)
      resultText = "Mittel! Deine Punktzahl: ${resultScore.toString()}";
    else
      resultText = "Gut! Deine Punktzahl: ${resultScore.toString()}";
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: resetHandler,
          child: Text("Neue Runde ?"),
        )
      ],
    ));
  }
}

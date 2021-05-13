import 'package:flutter/material.dart';
import 'answer.dart';
import 'storage.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> ans;
  final int roundIndex;
  final Function setScore;
  final Function startRound;
  final List<String> storage;
  final bool anzeige;

  Quiz(
      {@required this.ans,
      @required this.setScore,
      @required this.roundIndex,
      @required this.startRound,
      @required this.storage,
      @required this.anzeige});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Storage(storage.last),
        ElevatedButton(
            onPressed: startRound,
            child: roundIndex == 0 ? Text('Start') : Text('Weiter')),
        ...(ans[roundIndex]['rightAnswer'] as List<Map<String, Object>>)
            .map((answer) {
          return anzeige == true
              ? Answer(() => setScore(answer['score']), answer['code'])
              : Container(
                  width: 250,
                  margin: EdgeInsets.all(10),
                  child: Text(""),
                );
        }).toList(),
      ],
    );
  }
}

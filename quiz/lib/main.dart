import 'package:flutter/material.dart';
import 'package:quiz/result.dart';
import 'quiz.dart';
import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

main() {
  runApp(QuizM());
}

class QuizM extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizState();
  }
}

class QuizState extends State<QuizM> {
  var storage = ['Wenn du bereit bist, drücke auf Start.'];
  var codePool = [];
  var ans = [
    {
      'round': 0,
      'rightAnswer': [
        {'code': 'Mach dich bereit!', 'score': 0}
      ]
    }
  ];
  String code;
  var roundIndex = 0;
  var topScore = 0;
  static const turns = 5;
  var anzeige = true;

  Future startRound() async {
    var limit = 5;
    setState(() {
      storage.clear();
      storage.add("");
      anzeige = false;
    });
    codePool.clear();
    if (roundIndex < turns) {
      for (var i = 0; i <= limit; i++) {
        await new Future.delayed(const Duration(seconds: 3));
        setState(() {
          code = getRandomString(3);
          if (i == 5)
            storage.add("***");
          else
            storage.add(code);
        });
      }
    }
    gameRound();
    for (var i = 1; i <= 5; i++) {
      codePool.add(storage[i]);
    }
    for (var i = 0; i < 10; i++) {
      codePool.add(getRandomString(3));
    }
    var list = new List<int>.generate(15, (int index) => index);
    list.shuffle();
    List<Map<String, Object>> zeichen = [
      {
        'code': codePool[list[0]],
        'score': storage.contains(codePool[list[0]]) ? 10 : -10
      },
      {
        'code': codePool[list[1]],
        'score': storage.contains(codePool[list[1]]) ? 10 : -10
      },
      {
        'code': codePool[list[2]],
        'score': storage.contains(codePool[list[2]]) ? 10 : -10
      },
      {
        'code': codePool[list[3]],
        'score': storage.contains(codePool[list[3]]) ? 10 : -10
      },
      {
        'code': codePool[list[4]],
        'score': storage.contains(codePool[list[4]]) ? 10 : -10
      },
    ];
    setState(() {
      ans.add(
        {'round': roundIndex, 'rightAnswer': zeichen},
      );
      anzeige = true;
    });
  }

  void gameRound() {
    roundIndex = roundIndex + 1;
    print(roundIndex);
  }

  void setScore(int score) {
    topScore += score;
    if (roundIndex == turns - 1) roundIndex += 1;
    print(topScore);
  }

  void reset() {
    setState(() {
      roundIndex = 0;
      topScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gehirnleistungstest'),
        ),
        body: roundIndex < turns
            ? Quiz(
                ans: ans,
                setScore: setScore,
                roundIndex: roundIndex,
                startRound: startRound,
                storage: storage,
                anzeige: anzeige)
            : Result(topScore, reset),
        persistentFooterButtons: <Widget>[
          roundIndex == 0
              ? Text(
                  "Merken Sie sich die gezeigten Code-Kombinationen, welche aus drei Zeichen bestehen. Es werden Ihnen nacheinander 5 Kombinationen angezeigt. Anschließend kommen 5 Auswahlmöglichkeiten. Wählen Sie die zuvor gezeigten Codes aus. Bei einem treffer bekommen sie 10 Punkte. Bei einer falschen Auswahl -10 Punkte. Sie können auch einfach auf \"Weiter\" drücken.")
              : Text("Viel Erfolg!"),
        ],
      ),
    );
  }
}

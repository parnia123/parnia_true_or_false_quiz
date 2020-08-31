import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:true_false_quiz/data/config.dart';

import 'homepage.dart';
import 'play_quiz.dart';

class Result extends StatefulWidget {
  final int correct;
  final int incorrect;
  final int totalQuestion;
  final int level;

  const Result(
      {Key key,
      this.totalQuestion,
      this.correct,
      this.incorrect,
      @required this.level})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _verdict(),
          _score(),
          _detailedScore(),
          _tryAgain(),
          _goHome(),
        ],
      ),
    );
  }

  _verdict() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text(
          _getVerdict(),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _score() {
    return Container(
      child: Text(
          "You scored ${_getScore()} out of ${widget.totalQuestion * Config.pointPerCorrectAnswer}"),
    );
  }

  _detailedScore() {
    return Container(
      child: Text(
        "${widget.correct} correct, ${widget.incorrect} incorrect & ${Config.totalQuestions - (widget.correct + widget.incorrect)} not attempted out of ${widget.totalQuestion}",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  _tryAgain() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: RaisedButton(
          onPressed: () {
            log(widget.level.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayQuiz(
                          level: widget.level,
                        )));
          },
          child: Text("Reply Quiz Now"),
        ),
      ),
    );
  }

  _goHome() {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text("Go Home"),
      ),
    );
  }

  int _getScore() {
    return (widget.correct * Config.pointPerCorrectAnswer) -
        (widget.incorrect * Config.pointPerIncorrectAnswer);
  }

  String _getVerdict() {
    var totalScore = widget.totalQuestion * Config.pointPerCorrectAnswer;
    var score = _getScore();
    var scoreInPercentage = score / totalScore * 100;

    if (scoreInPercentage >= 100) {
      return "You are awesome!";
    }

    if (scoreInPercentage < 100 && scoreInPercentage > 50) {
      return "Not bad!";
    }

    return "Better luck next time!";
  }
}

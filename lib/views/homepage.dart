import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_false_quiz/views/play_quiz.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _level = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayQuiz(
                              level: _level,
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                decoration: BoxDecoration(
                    color: Colors.cyan[200],
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  "Start Quiz Now ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoSlidingSegmentedControl(
              children: _difficultyLevels(),
              onValueChanged: (int value) {
                setState(() {
                  _level = value;
                });
              },
              groupValue: _level,
            )
          ],
        ),
      ),
    );
  }

  _difficultyLevels() {
    return <int, Widget>{
      0: Text("Easy"),
      1: Text("Medium"),
      2: Text("Hard"),
    };
  }
}

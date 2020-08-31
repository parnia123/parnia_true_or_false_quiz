import 'package:flutter/material.dart';
import 'package:true_false_quiz/data/config.dart';
import 'package:true_false_quiz/models/question_model.dart';
import 'package:true_false_quiz/services/question_generator.dart';
import 'package:true_false_quiz/views/result.dart';

import '../models/question_model.dart';

class PlayQuiz extends StatefulWidget {
  final int level;

  const PlayQuiz({Key key, @required this.level}) : super(key: key);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz>
    with SingleTickerProviderStateMixin {
  List<Question> questions = new List<Question>();
  int index = 0;
  int points = 0;
  int correct = 0;
  int incorrect = 0;

  AnimationController controller;

  Animation animation;

  double beginAnim = 0.0;

  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();

    questions = QuestionGenerator().getQuestions(Config.totalQuestions);

    controller = AnimationController(
        duration: Config.levelDurations[widget.level], vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
          // Change here any Animation object value.
        });
      });

    startProgress();

    animation.addStatusListener((AnimationStatus animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        if (index < questions.length - 1) {
          index++;
          resetProgress();
          startProgress();
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                        totalQuestion: questions.length,
                        correct: correct,
                        incorrect: incorrect,
                        level: widget.level,
                      )));
        }
      }
    });
  }

  startProgress() {
    controller.forward();
  }

  stopProgress() {
    controller.stop();
  }

  resetProgress() {
    controller.reset();
  }

  void nextQuestion() {
    if (index < questions.length - 1) {
      index++;
      resetProgress();
      startProgress();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Result(
                    totalQuestion: questions.length,
                    correct: correct,
                    incorrect: incorrect,
                    level: widget.level,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${index + 1}/${questions.length}",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Question",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "$points",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Points",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              questions[index].question + "?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: LinearProgressIndicator(
              value: animation.value,
            )),
            Image.asset(questions[index].imageUrl),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      if (questions[index].answer) {
                        setState(() {
                          points = points + Config.pointPerCorrectAnswer;
                          nextQuestion();
                          correct++;
                        });
                      } else {
                        setState(() {
                          points = points - Config.pointPerIncorrectAnswer;
                          nextQuestion();
                          incorrect++;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(24)),
                      child: Text(
                        "True",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      if (!questions[index].answer) {
                        setState(() {
                          points = points + Config.pointPerCorrectAnswer;
                          nextQuestion();
                          correct++;
                        });
                      } else {
                        setState(() {
                          points = points - Config.pointPerIncorrectAnswer;
                          nextQuestion();
                          incorrect++;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(24)),
                      child: Text(
                        "False",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

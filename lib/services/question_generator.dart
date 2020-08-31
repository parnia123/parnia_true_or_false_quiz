import 'dart:math';

import '../models/question_model.dart';

class QuestionGenerator {
  List<Question> _questions = new List<Question>();

  QuestionGenerator() {
    _buildQuestions();
  }

  void _buildQuestions() {
    _questions.add(Question(
      question: "Giraffes have blue tongues!",
      answer: true,
      imageUrl: "images/giraffe.jpg",
    ));

    _questions.add(Question(
      question: "A shark can blink its eyes",
      answer: true,
      imageUrl: "images/shark.jpg",
    ));

    _questions.add(Question(
      question: "Elephant drink through their trunk",
      answer: false,
      imageUrl: "images/elephant.jpg",
    ));

    _questions.add(Question(
      question: "Horses can sleep standing up",
      answer: true,
      imageUrl: "images/horse.jpg",
    ));

    _questions.add(Question(
      question: "Camels store water in their humps",
      answer: false,
      imageUrl: "images/camel.jpg",
    ));

    _questions.add(Question(
      question: "Bats are not blind",
      answer: true,
      imageUrl: "images/bats.jpg",
    ));

    _questions.add(Question(
      question: "Bulls are enraged by the colour red",
      answer: false,
      imageUrl: "images/Bull.jpg",
    ));

    _questions.add(Question(
      question: "Ostriches bury their heads in sand",
      answer: false,
      imageUrl: "images/ostrich.jpg",
    ));

    _questions.add(Question(
      question: "Cheetahs are the fastest animal in the world",
      answer: false,
      imageUrl: "images/cheetah.jpg",
    ));

    _questions.add(Question(
      question: "Dolphins call each other by their name",
      answer: true,
      imageUrl: "images/dolphin.jpg",
    ));
  }

  List<Question> getQuestions(int numberOfQuestions) {
    var random = Random(DateTime.now().millisecondsSinceEpoch);
    var result = List<Question>();

    while (_questions.length > 0 && result.length < numberOfQuestions) {
      // pick a random index
      var index = random.nextInt(_questions.length);

      // add the random question to our results
      result.add(_questions[index]);

      // remove the question from the stash so it doesn't get added again
      _questions.removeAt(index);
    }

    return result;
  }
}

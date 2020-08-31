import 'package:flutter/widgets.dart';

class Question {
  final String question;
  final bool answer;
  final String imageUrl;

  Question({
    @required this.question,
    @required this.answer,
    @required this.imageUrl,
  });
}

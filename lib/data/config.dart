abstract class Config {
  static int pointPerCorrectAnswer = 20;
  static int pointPerIncorrectAnswer = 5;
  static int totalQuestions = 10;
  static Map<int, Duration> levelDurations = {
    0: Duration(seconds: 9), // Easy
    1: Duration(seconds: 6), // Medium
    2: Duration(seconds: 3), // Hard
  };
}

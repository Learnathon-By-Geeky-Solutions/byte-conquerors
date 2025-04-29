class Phq9QuestionModel {
  final String questionText;
  int selectedOption;

  Phq9QuestionModel({
    required this.questionText,
    this.selectedOption = -1,
  });
}

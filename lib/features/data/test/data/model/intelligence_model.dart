class IntelligenceModel {
  final String question;
  final List<IntelligenceAnswer>? answer;
  IntelligenceModel({required this.question, required this.answer});
  factory IntelligenceModel.fromJson(Map<String, dynamic> jsonObject) {
    var answerList = (jsonObject['answers'] as List<dynamic>?)
            ?.map(
              (item) => IntelligenceAnswer.fromJson(item),
            )
            .toList() ??
        [];
    return IntelligenceModel(
      question: jsonObject['question'],
      answer: answerList,
    );
  }
}

class IntelligenceAnswer {
  final int questionId;
  final int answerId;
  final String question;
  final String answer;
  IntelligenceAnswer({
    required this.questionId,
    required this.answerId,
    required this.question,
    required this.answer,
  });
  factory IntelligenceAnswer.fromJson(Map<String, dynamic> jsonObject) {
    return IntelligenceAnswer(
      questionId: jsonObject['question_id'],
      answerId: jsonObject['id'] ?? 0,
      question: jsonObject['question'] ?? '',
      answer: jsonObject['answer'],
    );
  }
}

class AutismTestModel {
  final String question;
  final List<AutismAnswer>? answer;
  AutismTestModel({required this.question, required this.answer});
  factory AutismTestModel.fromJson(Map<String, dynamic> jsonObject) {
    var userAnswerList = (jsonObject['user_answers'] as List<dynamic>?)
            ?.map(
              (item) => AutismAnswer.fromJson(item),
            )
            .toList() ??
        [];
    return AutismTestModel(
      question: jsonObject['question'],
      answer: userAnswerList,
    );
  }
}

class AutismAnswer {
  final int questionId;
  final int answerId;
  final String question;
  final String answer;
  AutismAnswer({
    required this.questionId,
    required this.answerId,
    required this.question,
    required this.answer,
  });
  factory AutismAnswer.fromJson(Map<String, dynamic> jsonObject) {
    return AutismAnswer(
      questionId: jsonObject['question_id'],
      answerId: jsonObject['id'] ?? 0,
      question: jsonObject['question'] ?? '',
      answer: jsonObject['user_answer'],
    );
  }
}

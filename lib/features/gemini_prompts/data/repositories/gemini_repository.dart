import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  final GenerativeModel model;

  GeminiRepository(this.model);

  Future<String> getGeminiResponse(String prompt) async {
    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "No response received.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}

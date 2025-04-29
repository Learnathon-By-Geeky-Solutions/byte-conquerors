import 'package:soul_space/features/gemini_prompts/data/repositories/gemini_repository.dart';

class GeminiUseCase {
  final GeminiRepository repository;

  GeminiUseCase(this.repository);

  Future<String> execute(String prompt) async {
    return repository.getGeminiResponse(prompt);
  }
}

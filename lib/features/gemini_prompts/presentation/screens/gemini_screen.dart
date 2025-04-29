import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/gemini_prompts/presentation/bloc/gemini_bloc.dart';

class GeminiScreen extends StatelessWidget {
  const GeminiScreen({super.key});

  final List<String> prompts = const [
    'How can I reduce stress before bed?',
    'Give me 3 affirmations to boost my confidence.',
    'Suggest a 5-minute mindfulness routine.',
    'Tips to improve focus during study.',
    'How to deal with negative thoughts?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask SoulBot')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select a question below:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: prompts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final prompt = prompts[index];
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<GeminiBloc>()
                          .add(GeminiPromptSelected(prompt));
                    },
                    child: Text(prompt),
                  );
                },
              ),
            ),
            const Divider(height: 32),
            BlocBuilder<GeminiBloc, GeminiState>(
              builder: (context, state) {
                if (state is GeminiLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GeminiLoaded) {
                  return Text(
                    state.response,
                    style: const TextStyle(fontSize: 16),
                  );
                } else if (state is GeminiError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const Text('Awaiting your prompt...');
              },
            ),
          ],
        ),
      ),
    );
  }
}

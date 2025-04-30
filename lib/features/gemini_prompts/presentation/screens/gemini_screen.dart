import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/gemini_prompts/presentation/bloc/gemini_bloc.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  String? selectedPrompt;
  bool showPromptButtons = false;

  final List<String> prompts = const [
    'How can I reduce stress before bed?',
    'Give me 3 affirmations to boost my confidence.',
    'Suggest a 5-minute mindfulness routine.',
    'Tips to improve focus during study.',
    'How to deal with negative thoughts?',
  ];

  void _onPromptTap(String prompt) {
    setState(() {
      selectedPrompt = prompt;
      showPromptButtons = false;
    });
    context.read<GeminiBloc>().add(GeminiPromptSelected(prompt));
  }

  void _onBackToPromptList() {
    setState(() {
      selectedPrompt = null;
    });
    context.read<GeminiBloc>().emit(GeminiInitial());
  }

  void _togglePromptButtons() {
    setState(() {
      showPromptButtons = !showPromptButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Ask SoulBot',
            style: TextStyle(
              color: AppColors.lighFont,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: selectedPrompt == null
                ? const Center(
                    child: Text(
                    "Select a prompt from the floating button",
                    style: TextStyle(
                      color: AppColors.darkFont,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
                : Column(
                    children: [
                      Expanded(child: _buildFocusedResponse()),
                    ],
                  ),
          ),

          // Prompt buttons displayed when FAB is toggled
          if (selectedPrompt == null && showPromptButtons)
            ...List.generate(prompts.length, (index) {
              final prompt = prompts[index];
              return Positioned(
                bottom: 80.0 + (index * 60),
                right: 16,
                child: FloatingActionButton.extended(
                  heroTag: 'prompt_$index',
                  onPressed: () => _onPromptTap(prompt),
                  label: Text(
                    prompt.length > 20
                        ? '${prompt.substring(0, 20)}...'
                        : prompt,
                    overflow: TextOverflow.ellipsis,
                  ),
                  icon: const Icon(Icons.question_answer),
                ),
              );
            }),
        ],
      ),
      floatingActionButton: selectedPrompt != null
          ? FloatingActionButton.extended(
              onPressed: _onBackToPromptList,
              label: const Text("Back to Prompts"),
              icon: const Icon(Icons.arrow_back),
            )
          : FloatingActionButton(
              onPressed: _togglePromptButtons,
              child: Icon(showPromptButtons ? Icons.close : Icons.add),
            ),
    );
  }

  Widget _buildFocusedResponse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedPrompt!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkFont,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<GeminiBloc, GeminiState>(
            builder: (context, state) {
              if (state is GeminiLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GeminiLoaded) {
                return SingleChildScrollView(
                  child: Text(
                    state.response,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              } else if (state is GeminiError) {
                return Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const Text(
                'Awaiting response...',
                style: TextStyle(
                  color: AppColors.darkFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

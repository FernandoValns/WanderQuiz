import 'package:flutter/material.dart';
import '../data/dummy_quiz.dart';
import '../widgets/app_scalfoder.dart';
import '../widgets/question_widget.dart';
import '../widgets/option_card.dart';
import '../widgets/custom_button.dart';

class QuestionScreen extends StatefulWidget {
  final String playerName;

  const QuestionScreen({super.key, required this.playerName});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _nextQuestion() {
    if (_selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih salah satu jawaban dulu ya pengguna!'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }

    // Check if answer is correct
    if (_selectedOptionIndex == wanderQuizQuestions[_currentIndex].correctAnswerIndex) {
      _score++;
    }

    if (_currentIndex < wanderQuizQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Kuis Selesai!'),
          content: Text('Skor kamu: $_score dari ${wanderQuizQuestions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Return to welcome page
              },
              child: const Text('Selesai'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentQuestion = wanderQuizQuestions[_currentIndex];

    return AppScalfoder(
      title: 'WANDER QUIZ',
      subtitle: 'Soal ${currentQuestion.index} dari ${wanderQuizQuestions.length}',
      showHeader: true,
      headerHeightFactor: 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentIndex + 1) / wanderQuizQuestions.length,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFAED581)),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: size.height * 0.02),

          // User Name above the question (as requested)
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                'Pengguna: ${widget.playerName}',
                style: TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.015),

          // Question Card Widget
          QuestionWidget(questionText: currentQuestion.questionText),
          SizedBox(height: size.height * 0.03),

          // Option Cards
          ...List.generate(
            currentQuestion.options.length,
            (index) => OptionCard(
              optionText: currentQuestion.options[index],
              isSelected: _selectedOptionIndex == index,
              onTap: () => _selectOption(index),
            ),
          ),
          SizedBox(height: size.height * 0.04),

          // Action Button
          CustomButton(
            text: _currentIndex == wanderQuizQuestions.length - 1
                ? 'Selesai & Lihat Skor'
                : 'Selanjutnya',
            onPressed: _nextQuestion,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/dummy_quiz.dart';
import '../widgets/app_scalfoder.dart';
import '../widgets/question_widget.dart';
import '../widgets/option_card.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';


class QuestionScreen extends StatefulWidget {
  final String playerName;

  const QuestionScreen({super.key, required this.playerName});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // state variables yang terhubung dengan welcome screen
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  late final List<int?> _userAnswers;

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(wanderQuizQuestions.length, null);
  }

  void _onOptionSelected(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _onNextQuestion() {
    if (_selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih salah satu jawaban dulu ya pengguna!'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }

    // Save answer in state array so if rotated answer is not reset
    _userAnswers[_currentIndex] = _selectedOptionIndex;

    if (_currentIndex < wanderQuizQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = _userAnswers[_currentIndex];
      });
    } else {
      // Navigate to ResultScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            playerName: widget.playerName,
            userAnswers: _userAnswers,
            questions: wanderQuizQuestions,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final currentQuestion = wanderQuizQuestions[_currentIndex];

    return AppScalfoder(
      title: 'WANDER QUIZ',
      subtitle: '',
      showHeader: true,
      horizontalHeader: true,
      child: Column(
        key: const PageStorageKey('question_screen_flow'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentIndex + 1) / wanderQuizQuestions.length,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFAED581)),
            minHeight: isLandscape ? 4 : 6,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: isLandscape ? size.height * 0.015 : size.height * 0.02),

          // User Name above the question
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                'Pengguna: ${widget.playerName}',
                style: TextStyle(
                  fontSize: isLandscape ? size.width * 0.03 : size.width * 0.038,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: isLandscape ? size.height * 0.01 : size.height * 0.015),

          // Question Card Widget
          QuestionWidget(
            questionText: currentQuestion.questionText,
            imageAsset: currentQuestion.imageAsset,
          ),
          SizedBox(height: isLandscape ? size.height * 0.02 : size.height * 0.03),

          // Option Cards
          ...List.generate(
            currentQuestion.options.length,
            (index) => OptionCard(
              optionText: currentQuestion.options[index],
              isSelected: _selectedOptionIndex == index,
              onTap: () => _onOptionSelected(index),
            ),
          ),
          SizedBox(height: isLandscape ? size.height * 0.03 : size.height * 0.04),

          // Action Button
          CustomButton(
            text: _currentIndex == wanderQuizQuestions.length - 1
                ? 'Selesai & Lihat Skor'
                : 'Selanjutnya',
            onPressed: _onNextQuestion,
          ),
        ],
      ),
    );
  }
}

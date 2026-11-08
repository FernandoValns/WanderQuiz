import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/app_scalfoder.dart';
import '../widgets/custom_button.dart';
import '../widgets/result_item_card.dart';
import 'welcome_page.dart';

class ResultScreen extends StatelessWidget {
  final String playerName;
  final List<int?> userAnswers;
  final List<Question> questions;

  const ResultScreen({
    super.key,
    required this.playerName,
    required this.userAnswers,
    required this.questions,
  });

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && userAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final score = _calculateScore();
    final total = questions.length;

    return AppScalfoder(
      title: 'HASIL PETUALANGAN',
      subtitle: 'Tinjauan Kuis Geografi',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // hasil skor dan nama pengguna
          Text(
            'Ini skor Kamu, $playerName!',
            style: TextStyle(
              fontSize: isLandscape ? 20.0 : size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isLandscape ? 12.0 : 20.0),
          Container(
            padding: EdgeInsets.all(isLandscape ? 14.0 : 20.0),
            decoration: BoxDecoration(
              color: const Color(0xFFAED581).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFAED581),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Skor Akhir Kamu',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Text(
                  '$score / $total',
                  style: TextStyle(
                    fontSize: isLandscape ? 32.0 : size.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF689F38),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isLandscape ? 16.0 : 24.0),

          // bagian review dari jawaban
          Text(
            'Rincian Jawaban (Review)',
            style: TextStyle(
              fontSize: isLandscape ? 16.0 : size.width * 0.045,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: isLandscape ? 8.0 : 12.0),

          // list soal dengan mengambil ResultItemCard
          ...List.generate(questions.length, (index) {
            return ResultItemCard(
              question: questions[index],
              userAnswer: userAnswers[index],
            );
          }),
          SizedBox(height: isLandscape ? 16.0 : 24.0),

          // Restart Button
          CustomButton(
            text: 'Ulangi Petualangan',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/question_model.dart';

class ResultItemCard extends StatelessWidget {
  final Question question;
  final int? userAnswer;

  const ResultItemCard({
    super.key,
    required this.question,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    final bool isOverallCorrect = userAnswer != null && userAnswer == question.correctAnswerIndex;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.012),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOverallCorrect 
              ? Colors.green.withValues(alpha: 0.6) 
              : Colors.red.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isOverallCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isOverallCorrect ? Colors.green : Colors.red,
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Soal ${question.index}: ${question.questionText}',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          if (question.imageAsset != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.black12,
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.16,
                ),
                child: Image.asset(
                  question.imageAsset!,
                  width: double.infinity,
                  fit: BoxFit.contain, // Changed from cover to contain
                ),
              ),
            ),
            SizedBox(height: size.height * 0.015),
          ],
          SizedBox(height: size.height * 0.005),

          // Display all options with color coding
          ...List.generate(question.options.length, (optIndex) {
            final bool isThisCorrectAnswer = optIndex == question.correctAnswerIndex;
            final bool isThisUserChoice = optIndex == userAnswer;

            Color borderColor = Colors.grey.withValues(alpha: 0.3);
            Color bgColor = Colors.transparent;
            IconData? optionIcon;
            Color iconColor = Colors.grey;

            if (isThisCorrectAnswer) {
              borderColor = Colors.green;
              bgColor = Colors.green.withValues(alpha: 0.15);
              optionIcon = Icons.check_rounded;
              iconColor = Colors.green;
            } else if (isThisUserChoice && !isThisCorrectAnswer) {
              borderColor = Colors.red;
              bgColor = Colors.red.withValues(alpha: 0.15);
              optionIcon = Icons.close_rounded;
              iconColor = Colors.red;
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.012,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                  color: borderColor, 
                  width: (isThisCorrectAnswer || isThisUserChoice) ? 1.5 : 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  if (optionIcon != null) ...[
                    Icon(optionIcon, color: iconColor, size: 18),
                    const SizedBox(width: 8),
                  ] else ...[
                    const SizedBox(width: 26),
                  ],
                  Expanded(
                    child: Text(
                      question.options[optIndex],
                      style: TextStyle(
                        fontSize: size.width * 0.036,
                        fontWeight: (isThisCorrectAnswer || isThisUserChoice) 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

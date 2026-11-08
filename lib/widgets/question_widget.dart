import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String questionText;
  final String? imageAsset;

  const QuestionWidget({
    super.key,
    required this.questionText,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLandscape ? 16.0 : size.width * 0.05),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFAED581).withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          if (imageAsset != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: isLandscape ? 160.0 : size.height * 0.22,
                ),
                child: Image.asset(
                  imageAsset!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: isLandscape ? 10.0 : size.height * 0.02),
          ],
          Text(
            questionText,
            style: TextStyle(
              fontSize: isLandscape ? 16.0 : size.width * 0.048,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

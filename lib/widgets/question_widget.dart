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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.05),
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
                color: Colors.black12,
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.22,
                ),
                child: Image.asset(
                  imageAsset!,
                  width: double.infinity,
                  fit: BoxFit.contain, // Changed from cover to contain so images are not cropped
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
          Text(
            questionText,
            style: TextStyle(
              fontSize: size.width * 0.048,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

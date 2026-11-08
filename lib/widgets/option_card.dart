import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.018,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFAED581).withValues(alpha: 0.25)
                  : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFAED581)
                    : Colors.grey.withValues(alpha: 0.3),
                width: isSelected ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isSelected ? const Color(0xFFAED581) : Colors.grey,
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Text(
                    optionText,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'gradients.dart';

class AppScalfoder extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final bool showHeader;
  final double headerHeightFactor;

  const AppScalfoder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.showHeader = true,
    this.headerHeightFactor = 0.22,
  });

  @override
  Widget build(BuildContext context) {
    // Centralized MediaQuery responsiveness for the entire app layout
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (showHeader)
                Container(
                  width: double.infinity,
                  height: size.height * headerHeightFactor,
                  decoration: AppGradients.headerBoxDecoration(size),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: size.height * 0.015,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.quiz_rounded,
                          size: size.width * 0.12,
                          color: Colors.white,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: size.width * 0.065,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.08),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

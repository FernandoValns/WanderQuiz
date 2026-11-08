import 'package:flutter/material.dart';
import 'gradients.dart';

class AppScalfoder extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final bool showHeader;
  final bool showBackButton;
  final bool horizontalHeader;
  final double headerHeightFactor;
  final IconData headerIcon;
  final String? headerImageAsset;

  const AppScalfoder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.showHeader = true,
    this.showBackButton = false,
    this.horizontalHeader = false,
    this.headerHeightFactor = 0.22,
    this.headerIcon = Icons.public,
    this.headerImageAsset,
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
                  height: size.height * (horizontalHeader ? 0.09 : headerHeightFactor),
                  decoration: AppGradients.headerBoxDecoration(size),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.01,
                    ),
                    child: horizontalHeader
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (headerImageAsset != null)
                                Image.asset(
                                  headerImageAsset!,
                                  height: size.width * 0.16, // Made slightly larger as requested
                                  fit: BoxFit.contain,
                                )
                              else
                                Icon(
                                  headerIcon,
                                  size: size.width * 0.16,
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

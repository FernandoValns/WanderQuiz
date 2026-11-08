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
  final IconData? headerIcon;
  final String? headerImageAsset;

  const AppScalfoder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.showHeader = true,
    this.showBackButton = false,
    this.horizontalHeader = false,
    this.headerHeightFactor = 0.26,
    this.headerIcon,
    this.headerImageAsset,
  });

  @override
  Widget build(BuildContext context) {
    // Centralized MediaQuery responsiveness for the entire app layout
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final bool hasHeaderIcon = headerImageAsset != null || headerIcon != null;

    double calculatedHeaderHeight;
    if (horizontalHeader) {
      calculatedHeaderHeight = isLandscape ? 56.0 : size.height * 0.1;
    } else if (!hasHeaderIcon) {
      calculatedHeaderHeight = isLandscape ? 56.0 : size.height * 0.13;
    } else {
      calculatedHeaderHeight = isLandscape ? size.height * 0.45 : size.height * headerHeightFactor;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (showHeader)
                Container(
                  width: double.infinity,
                  height: calculatedHeaderHeight,
                  decoration: AppGradients.headerBoxDecoration(size),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: isLandscape ? 4.0 : size.height * 0.01,
                    ),
                    child: horizontalHeader
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: isLandscape ? 20.0 : size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (headerImageAsset != null) ...[
                                Image.asset(
                                  headerImageAsset!,
                                  height: isLandscape ? 60.0 : size.width * 0.26,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: isLandscape ? 4.0 : size.height * 0.01),
                              ] else if (headerIcon != null) ...[
                                Icon(
                                  headerIcon,
                                  size: isLandscape ? 60.0 : size.width * 0.26,
                                  color: Colors.white,
                                ),
                                SizedBox(height: isLandscape ? 4.0 : size.height * 0.01),
                              ],
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: isLandscape ? 22.0 : size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              if (subtitle.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: isLandscape ? 12.0 : size.width * 0.035,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ],
                          ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(isLandscape ? 16.0 : size.width * 0.08),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

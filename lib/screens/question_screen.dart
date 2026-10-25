import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  final String playerName;

  const QuestionScreen({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Tekaku'),
        backgroundColor: const Color(0xFFAED581),
      ),
      body: Center(
        child: Text(
          'belum dibuat .',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

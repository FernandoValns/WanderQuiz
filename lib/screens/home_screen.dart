import 'package:flutter/material.dart';
import 'question_screen.dart';
import '../widgets/app_scalfoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      final playerName = _nameController.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionScreen(playerName: playerName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return AppScalfoder(
      title: 'TEKAKU',
      subtitle: 'Tebak Kataku & Lelucon Seru',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Masukkan nama kamu untuk mulai menebak lelucon.',
              style: TextStyle(
                fontSize: size.width * 0.038,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.04),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Kamu',
                hintText: 'Contoh: Budi Kocak',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tidak boleh kosong ya!';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.04),
            ElevatedButton(
              onPressed: _startQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAED581),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.018,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: Text(
                'Mulai Kuis Sekarang',
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

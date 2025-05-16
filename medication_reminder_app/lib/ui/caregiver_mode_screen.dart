import 'package:flutter/material.dart';

class CaregiverModeScreen extends StatelessWidget {
  const CaregiverModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Cuidador'),
      ),
      body: const Center(
        child: Text(
            'As funcionalidades do modo cuidador serão exibidas aqui.'),
      ),
    );
  }
}

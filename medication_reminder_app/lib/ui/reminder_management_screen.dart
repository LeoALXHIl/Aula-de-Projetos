import 'package:flutter/material.dart';

class ReminderManagementScreen extends StatelessWidget {
  const ReminderManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Lembretes'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Lógica para configurar lembretes
          },
          child: const Text('Configurar Lembrete'),
        ),
      ),
    );
  }
}

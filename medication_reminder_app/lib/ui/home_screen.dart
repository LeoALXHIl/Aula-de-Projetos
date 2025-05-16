import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lembrete de Medicamentos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bem-vindo de volta!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Escolha uma opção abaixo:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildNavigationButton(
                  context,
                  icon: Icons.add,
                  label: 'Adicionar',
                  destination: AddMedicationScreen(),
                ),
                _buildNavigationButton(
                  context,
                  icon: Icons.list,
                  label: 'Lista',
                  destination: MedicationListScreen(),
                ),
                _buildNavigationButton(
                  context,
                  icon: Icons.alarm,
                  label: 'Alarmes',
                  destination: AlarmScreen(),
                ),
                _buildNavigationButton(
                  context,
                  icon: Icons.settings,
                  label: 'Configurações',
                  destination: SettingsScreen(),
                ),
                _buildNavigationButton(
                  context,
                  icon: Icons.info,
                  label: 'Sobre',
                  destination: AboutScreen(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

// Substitua as telas abaixo pelas implementações reais
class AddMedicationScreen extends StatelessWidget {
  const AddMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Medicamento')),
      body: const Center(child: Text('Tela de Adicionar Medicamento')),
    );
  }
}

class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Medicamentos')),
      body: const Center(child: Text('Tela de Lista de Medicamentos')),
    );
  }
}

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarmes')),
      body: const Center(child: Text('Tela de Alarmes')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const Center(child: Text('Tela de Configurações')),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: const Center(child: Text('Tela Sobre')),
    );
  }
}

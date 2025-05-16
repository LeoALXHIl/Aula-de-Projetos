import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração de Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isDark ? Icons.nightlight_round : Icons.wb_sunny,
                    size: 32),
                const SizedBox(width: 12),
                Text(
                  isDark ? 'Modo Escuro Ativo' : 'Modo Claro Ativo',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isDark
                  ? 'O modo escuro reduz o brilho da tela e pode ser mais confortável à noite.'
                  : 'O modo claro utiliza cores mais claras e é ideal para ambientes bem iluminados.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Center(
                child: Text(
                  isDark ? 'Prévia do Modo Escuro' : 'Prévia do Modo Claro',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Dica: O modo escuro pode ajudar a reduzir o cansaço visual em ambientes com pouca luz.',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Escolha o tema:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.wb_sunny, color: Colors.amber),
                    label: const Text('Claro'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isDark ? Colors.blue : Colors.grey[300],
                      foregroundColor: !isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      themeProvider.setLightMode();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tema claro ativado!')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.nightlight_round,
                        color: Colors.blueGrey),
                    label: const Text('Escuro'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark ? Colors.blueGrey : Colors.grey[300],
                      foregroundColor: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      themeProvider.setDarkMode();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tema escuro ativado!')),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.phone_android, color: Colors.green),
                label: const Text('Usar tema do sistema'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.green[900],
                ),
                onPressed: () {
                  themeProvider.setSystemTheme();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tema do sistema ativado!')),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Você pode alterar o tema a qualquer momento para melhorar sua experiência visual.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

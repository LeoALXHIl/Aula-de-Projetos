import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medication_reminder_app/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'ui/theme_settings_screen.dart';
import 'ui/add_medication_screen.dart' as add_med;

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Medication Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Stack(
          children: [
            HomeScreen(),
            // FloatingActionButton overlay
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.assignment),
                label: const Text('Cadastro Completo'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => add_med.AddMedicationScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

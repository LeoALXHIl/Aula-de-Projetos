import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Reminder')),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMedicationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddMedicationScreen extends StatelessWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medication')),
      body: const Center(child: Text('Add Medication Screen')),
    );
  }
}

void main() {
  testWidgets('HomeScreen displays medication list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the title is displayed
    expect(find.text('Medication Reminder'), findsOneWidget);

    // Verify that the medication list is displayed
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('HomeScreen navigates to AddMedicationScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Tap the add medication button
    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Verify that the AddMedicationScreen is displayed
    expect(find.text('Add Medication'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'add_medication_screen.dart';

class AdherenceHistoryScreen extends StatefulWidget {
  const AdherenceHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AdherenceHistoryScreen> createState() => _AdherenceHistoryScreenState();
}

class _AdherenceHistoryScreenState extends State<AdherenceHistoryScreen> {
  final List<Map<String, dynamic>> _adherenceTimeline = [
    {
      'medicationName': 'Medication 1',
      'time': '2023-10-01 at 8:00 AM',
      'status': 'Tomado',
      'statusColor': Colors.green,
    },
    {
      'medicationName': 'Medication 2',
      'time': '2023-10-01 at 2:00 PM',
      'status': 'Esquecido',
      'statusColor': Colors.red,
    },
  ];

  final List<String> _alarms = [];

  void _addAdherenceItem(String medicationName, String time) {
    setState(() {
      _adherenceTimeline.add({
        'medicationName': medicationName,
        'time': time,
        'status': 'Pendente',
        'statusColor': Colors.orange,
      });
    });
  }

  void _editAdherenceItem(int index, String newStatus, Color newColor) {
    setState(() {
      _adherenceTimeline[index]['status'] = newStatus;
      _adherenceTimeline[index]['statusColor'] = newColor;
    });
  }

  void _removeAdherenceItem(int index) {
    setState(() {
      _adherenceTimeline.removeAt(index);
    });
  }

  void _addAlarm() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _alarms.add(pickedTime.format(context));
      });
    }
  }

  void _showAlarms() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alarmes'),
        content: _alarms.isEmpty
            ? const Text('Nenhum alarme configurado.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: _alarms
                    .map((alarm) => ListTile(
                          leading: const Icon(Icons.alarm),
                          title: Text(alarm),
                        ))
                    .toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          TextButton(
            onPressed: _addAlarm,
            child: const Text('Adicionar Alarme'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddMedication() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMedicationScreen(),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      _addAdherenceItem(result['name'], result['time']);
    }
  }

  void _navigateToMedicationList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MedicationListScreen(),
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Adesão'),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm),
            onPressed: _showAlarms,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Linha do Tempo de Adesão',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _adherenceTimeline.length,
                itemBuilder: (context, index) {
                  final item = _adherenceTimeline[index];
                  return AdherenceTimelineItem(
                    medicationName: item['medicationName'],
                    time: item['time'],
                    status: item['status'],
                    statusColor: item['statusColor'],
                    onEdit: () => _editAdherenceItem(
                      index,
                      item['status'] == 'Pendente' ? 'Tomado' : 'Pendente',
                      item['status'] == 'Pendente'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    onRemove: () => _removeAdherenceItem(index),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToAddMedication,
              child: const Text('Adicionar Medicamento'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToMedicationList,
              child: const Text('Lista de Medicamentos'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdherenceTimelineItem extends StatelessWidget {
  final String medicationName;
  final String time;
  final String status;
  final Color statusColor;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const AdherenceTimelineItem({
    Key? key,
    required this.medicationName,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.onEdit,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          status == 'Tomado' ? Icons.check_circle : Icons.cancel,
          color: statusColor,
          size: 40,
        ),
        title: Text(
          medicationName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Horário: $time'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const Center(child: Text('Tela de Configurações')),
    );
  }
}

class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Medicamentos')),
      body: const Center(child: Text('Tela de Lista de Medicamentos')),
    );
  }
}

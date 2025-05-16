import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController =
      TextEditingController(text: 'Novo');
  String type = 'Medicamento';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  bool controlStock = false;
  final TextEditingController minStockController = TextEditingController();
  final TextEditingController currentStockController = TextEditingController();
  final TextEditingController lastMovementController = TextEditingController();
  bool sendSms = false;
  final TextEditingController returnForecastController =
      TextEditingController();
  String status = 'Ativo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Medicamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Cadastro de Medicamento',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        labelText: 'Código*',
                        border: OutlineInputBorder(),
                      ),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: type,
                      decoration: const InputDecoration(
                        labelText: 'Tipo*',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Medicamento', child: Text('Medicamento')),
                        DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => type = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome*',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: groupController,
                      decoration: const InputDecoration(
                        labelText: 'Grupo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: brandController,
                      decoration: const InputDecoration(
                        labelText: 'Marca',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: unitController,
                      decoration: const InputDecoration(
                        labelText: 'Unid. medida',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Controla Estoque?'),
                        Row(
                          children: [
                            Switch(
                              value: controlStock,
                              onChanged: (v) =>
                                  setState(() => controlStock = v),
                            ),
                            Text(controlStock ? 'SIM' : 'NÃO'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: minStockController,
                      decoration: const InputDecoration(
                        labelText: 'Estoque mínimo',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: currentStockController,
                      decoration: const InputDecoration(
                        labelText: 'Estoque atual',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: lastMovementController,
                decoration: const InputDecoration(
                  labelText: 'Última Movimentação',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Enviar SMS de Lembrete?'),
                        Row(
                          children: [
                            Switch(
                              value: sendSms,
                              onChanged: (v) => setState(() => sendSms = v),
                            ),
                            Text(sendSms ? 'SIM' : 'NÃO'),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Status:'),
                  const SizedBox(width: 16),
                  ChoiceChip(
                    label: const Text('ATIVO'),
                    selected: status == 'Ativo',
                    selectedColor: Colors.green,
                    onSelected: (v) => setState(() => status = 'Ativo'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('INATIVO'),
                    selected: status == 'Inativo',
                    selectedColor: Colors.red,
                    onSelected: (v) => setState(() => status = 'Inativo'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveMedication,
                child: const Text('Salvar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMedication() async {
    if (_formKey.currentState!.validate()) {
      final medication = {
        'code': codeController.text,
        'type': type,
        'name': nameController.text,
        'group': groupController.text,
        'brand': brandController.text,
        'unit': unitController.text,
        'controlStock': controlStock,
        'minStock': minStockController.text,
        'currentStock': currentStockController.text,
        'lastMovement': lastMovementController.text,
        'sendSms': sendSms,
        'returnForecast': returnForecastController.text,
        'status': status,
      };
      await FirebaseFirestore.instance
          .collection('medicamentos')
          .add(medication);
      Navigator.pop(context, medication);
    }
  }
}

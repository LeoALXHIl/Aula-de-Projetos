import 'package:flutter/material.dart';

class InteractionAlertScreen extends StatelessWidget {
  const InteractionAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas de Interação'),
      ),
      body: const Center(
        child: Text('Os alertas de interação serão exibidos aqui.'),
      ),
    );
  }
}

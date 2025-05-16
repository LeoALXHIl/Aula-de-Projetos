import '../models/medication.dart'; // Import remains the same

class InteractionChecker {
  Future<List<String>> checkInteractions(List<Medicamento> medicamentos) async {
    // Simulate API call to check interactions
    return medicamentos.length > 1
        ? [
            'Interação detectada entre ${medicamentos[0].nome} e ${medicamentos[1].nome}'
          ]
        : [];
  }
}

class Medicamento {
  final String nome;
  final double dosagem;
  final String viaDeAdministracao;
  final int frequencia;
  final List<DateTime> horariosEspecificos;
  final DateTime dataInicio;
  final DateTime dataFim;

  Medicamento({
    required this.nome,
    required this.dosagem,
    required this.viaDeAdministracao,
    required this.frequencia,
    required this.horariosEspecificos,
    required this.dataInicio,
    required this.dataFim,
  });

  bool validar() {
    if (dosagem <= 0) return false;
    if (horariosEspecificos.any((horario) => horario.isBefore(DateTime.now()))) {
      return false;
    }
    return true;
  }
}

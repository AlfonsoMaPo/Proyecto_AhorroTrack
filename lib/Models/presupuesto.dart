class Presupuesto {
  final String id;
  final String categoria;
  final double montoTotal;
  final double gastoTotal;

  Presupuesto({
    required this.id,
    required this.categoria,
    required this.montoTotal,
    required this.gastoTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoria': categoria,
      'montoTotal': montoTotal.toString(),
      'gastoTotal': gastoTotal.toString(),
    };
  }

  factory Presupuesto.fromJson(Map<String, dynamic> json, String id) {
    return Presupuesto(
      id: id,
      categoria: json['categoria'],
      montoTotal: double.parse(json['montoTotal']),
      gastoTotal: double.parse(json['gastoTotal']),
    );
  }
}

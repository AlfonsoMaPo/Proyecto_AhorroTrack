class RetoFinanciero {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completado;
  final String fechaInicio;
  final String fechaFin;
  final String uid;

  RetoFinanciero({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.completado,
    required this.fechaInicio,
    required this.fechaFin,
    required this.uid,
  });

  factory RetoFinanciero.fromJson(Map<String, dynamic> json, String id) {
    return RetoFinanciero(
      id: id,
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      completado: json['completado'],
      fechaInicio: json['fechaInicio'],
      fechaFin: json['fechaFin'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'completado': completado,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'uid': uid,
    };
  }
}

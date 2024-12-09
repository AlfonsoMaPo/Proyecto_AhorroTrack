class Meta {
  final String id;
  final String descripcion;
  final double montoObjetivo;
  final double progreso;
  final String uid;

  Meta({
    required this.id,
    required this.descripcion,
    required this.montoObjetivo,
    required this.progreso,
    required this.uid,
  });

  factory Meta.fromJson(Map<String, dynamic> json, String id) {
    return Meta(
      id: id,
      descripcion: json['descripcion'],
      montoObjetivo: json['montoObjetivo'],
      progreso: json['progreso'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'montoObjetivo': montoObjetivo,
      'progreso': progreso,
      'uid': uid,
    };
  }
}

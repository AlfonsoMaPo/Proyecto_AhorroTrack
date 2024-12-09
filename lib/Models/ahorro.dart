class Ahorro {
  final String id;
  final String monto;
  final String categoria;
  final String meses;
  final String uid;

  Ahorro({
    required this.id,
    required this.monto,
    required this.categoria,
    required this.meses,
    required this.uid,
  });

  factory Ahorro.fromJson(Map<String, dynamic> json, String id) {
    return Ahorro(
      id: id,
      monto:json['monto'],
      categoria: json['categoria'],
      meses:json['meses'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monto': monto.toString(),
      'categoria': categoria,
      'meses': meses.toString(),
      'uid': uid,
    };
  }
}

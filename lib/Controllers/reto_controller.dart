import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/retos.dart';


class RetoFinancieroController extends GetxController {
  final RxList<RetoFinanciero> retosFinancieros = <RetoFinanciero>[].obs;
  final FirebaseFirestore baseData = FirebaseFirestore.instance;

  @override
  onInit() {
    super.onInit();
    getRetosFinancieros();
  }

  getRetosFinancieros() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuario no autenticado");

      final QuerySnapshot snapshot = await baseData
          .collection('Retos')
          .where('uid', isEqualTo: user.uid)
          .get();

      final listaRetos = snapshot.docs
          .map((doc) => RetoFinanciero.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      retosFinancieros.value = listaRetos;
    } catch (e) {
      throw Exception('Error al obtener los retos financieros: $e');
    }
  }

  addRetoFinanciero(RetoFinanciero reto) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuario no encontrado");

      final nuevoReto = reto.toJson();
      nuevoReto['uid'] = user.uid;

      await baseData.collection('Retos').add(nuevoReto);
      getRetosFinancieros();
    } catch (e) {
      throw Exception('No se pudo agregar el reto financiero: $e');
    }
  }

  eliminarRetoFinanciero(String id) async {
    try {
      await baseData.collection('RetosFinancieros').doc(id).delete();
      getRetosFinancieros();
    } catch (e) {
      throw Exception('No se pudo eliminar el reto financiero: $e');
    }
  }

  actualizarEstadoReto(String id, bool completado) async {
    try {
      await baseData.collection('Retos').doc(id).update({'completado': completado});
      getRetosFinancieros();
    } catch (e) {
      throw Exception('No se pudo actualizar el estado del reto financiero: $e');
    }
  }
  clearRetoData() {
     retosFinancieros.clear();
     }

}

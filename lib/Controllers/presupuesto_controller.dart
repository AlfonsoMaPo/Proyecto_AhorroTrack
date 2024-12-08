import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/presupuesto.dart';

class PresupuestoController extends GetxController {
  final RxList<Presupuesto> presupuestos = <Presupuesto>[].obs;
  final FirebaseFirestore baseData = FirebaseFirestore.instance;




  getPresupuestos() async {
    try {
      final QuerySnapshot snapshot =
          await baseData.collection('Presupuestos').get();
      final listaPresupuestos = snapshot.docs
          .map((doc) =>
              Presupuesto.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      presupuestos.value = listaPresupuestos;
    } catch (e) {
      throw Exception('Error al obtener los presupuestos');
    }
  }

  @override
  onInit() {
    super.onInit();
    getPresupuestos();
  }

  addPresupuestos(Presupuesto presupuestos) async {
    try {
      await baseData.collection('Presupuestos').add(presupuestos.toJson());
    } catch (e) {
      throw Exception('No se pudo agregar al presupuesto');
    }
  }

  actualizarPresupuestos(Presupuesto presupuestos) async {
    try {
      await baseData
          .collection('Presupuestos')
          .doc(presupuestos.id)
          .update(presupuestos.toJson());
    } catch (e) {
      throw Exception('Error al actualizar los datos');
    }
  }

  eliminarPresupuestos(String id) async {
    try {
      await baseData.collection('Presupuestos').doc(id).delete();
    } catch (e) {
      throw Exception('No se pudo eliminar.');
    }
  }
}

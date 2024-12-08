import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/presupuesto.dart';

class PresupuestoController extends GetxController {
  final RxList<Presupuesto> presupuestos = <Presupuesto>[].obs;
  final FirebaseFirestore baseData = FirebaseFirestore.instance;
  final Rx<Presupuesto?> ultimoPresupuesto = Rx<Presupuesto?>(null);

  getPresupuestos() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser; 
      if (user == null) throw Exception("Usuario no autenticado");

      final QuerySnapshot snapshot =await baseData.collection('Presupuestos').where('uid',isEqualTo:user.uid).get();
      final listaPresupuestos = snapshot.docs.map((doc) =>
              Presupuesto.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
      presupuestos.value = listaPresupuestos;
    } catch (e) {
      throw Exception('Error al obtener los presupuestos');
    }
  }

  @override
  onInit() {
    super.onInit();
    getPresupuestos();
    getUltimoPresupuesto();
  }

  addPresupuestos(Presupuesto presupuestos) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser; 
      if (user == null) throw Exception("Usuario no autenticado");

      final nuevoPresupuesto = presupuestos.toJson();
      nuevoPresupuesto['uid'] = user.uid;

      await baseData.collection('Presupuestos').add(nuevoPresupuesto);
      getPresupuestos();
      getUltimoPresupuesto();
    } catch (e) {
      throw Exception('No se pudo agregar al presupuesto');
    }
  }

  actualizarPresupuestos(Presupuesto presupuestos) async {
    try {
      await baseData.collection('Presupuestos').doc(presupuestos.id).update(presupuestos.toJson());
      getPresupuestos();
      getUltimoPresupuesto();
    } catch (e) {
      throw Exception('Error al actualizar los datos');
    }
  }

  eliminarPresupuestos(String id) async {
    try {
      await baseData.collection('Presupuestos').doc(id).delete();
      getPresupuestos();
      getUltimoPresupuesto();
    } catch (e) {
      throw Exception('No se pudo eliminar.');
    }
  }

  getUltimoPresupuesto() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuario no autenticado");
      final QuerySnapshot snapshot = 
        await baseData.collection('Presupuestos').where(
          'uid', isEqualTo: user.uid).orderBy(
            FieldPath.documentId, descending: false).limit(1).get();
      
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        ultimoPresupuesto.value =
            Presupuesto.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        ultimoPresupuesto.value = null;
      }
    } catch (e) {
      throw Exception('No se pudo recuperar.');
    }
  }

  clearData() {
     presupuestos.clear();
     ultimoPresupuesto.value = null; 
     }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/ahorro.dart';

class AhorroController extends GetxController {
  final RxList<Ahorro> ahorros = <Ahorro>[].obs;
  final FirebaseFirestore baseData = FirebaseFirestore.instance;
  final Rx<Ahorro?> ultimoAhorro = Rx<Ahorro?>(null);

  @override
  void onInit() {
    super.onInit();
    getAhorros();
    getUltimoAhorro();
  }

  getAhorros() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final QuerySnapshot snapshot = await baseData
          .collection('Ahorros').where('uid', isEqualTo: user.uid).get();
      final listaAhorros = snapshot.docs
          .map((doc) =>Ahorro.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
      ahorros.value = listaAhorros;
      getUltimoAhorro();
    } catch (e) {
      throw Exception('Error al obtener los ahorros: $e');
    }
  }

  addAhorro(Ahorro ahorro) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final nuevoAhorro = ahorro.toJson();
      nuevoAhorro['uid'] = user.uid;

      await baseData.collection('Ahorros').add(nuevoAhorro);
      getAhorros();
      getUltimoAhorro();
    } catch (e) {
      throw Exception('No se pudo agregar el ahorro: $e');
    }
  }

  actualizarAhorro(Ahorro ahorro) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final ahorroActualizado = ahorro.toJson();
      ahorroActualizado['uid'] = user.uid;

      await baseData.collection('Ahorros').doc(ahorro.id).update(ahorroActualizado);
      await getAhorros();
      getUltimoAhorro();
    } catch (e) {
      throw Exception('Error al actualizar los datos: $e');
    }
  }

  eliminarAhorro(String id) async{
    try {
      await baseData.collection('Ahorros').doc(id).delete();
      getAhorros();
      getUltimoAhorro();
    } catch (e) {
      throw Exception('No se pudo eliminar: $e');
    }
  }

  getUltimoAhorro() async{
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final QuerySnapshot snapshot = await baseData.collection('Ahorros')
      .where('uid', isEqualTo: user.uid).orderBy(FieldPath.documentId, 
      descending: true).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        ultimoAhorro.value =
            Ahorro.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        ultimoAhorro.value = null;
      }
    } catch (e) {
      throw Exception('No se pudo recuperar: $e');
    }
  }

  clearDataahorro() {
    ahorros.clear();
    ultimoAhorro.value = null;
  }
}

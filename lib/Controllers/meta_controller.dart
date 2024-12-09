import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/meta.dart';

class MetaController extends GetxController {
  final RxList<Meta> metas = <Meta>[].obs;
  final FirebaseFirestore baseData = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    getMetas();
  }


  getMetas() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final QuerySnapshot snapshot = await baseData
          .collection('Metas') .where('uid', isEqualTo: user.uid).get();
      
      final listaMetas = snapshot.docs
          .map((doc) => Meta.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList(); 
      metas.value = listaMetas;
    } catch (e) {
      throw Exception('Error al obtener las metas: $e');
    }
  }

  addMeta(Meta meta) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final nuevaMeta = meta.toJson();
      nuevaMeta['uid'] = user.uid;

      await baseData.collection('Metas').add(nuevaMeta); 
      getMetas();
    } catch (e) {
      throw Exception('No se pudo agregar la meta: $e');
    }
  }

  eliminarMeta(String id) async {
    try {
      await baseData.collection('Metas').doc(id).delete(); 
      getMetas();
    } catch (e) {
      throw Exception('No se pudo eliminar la meta: $e');
    }
  }

  actualizarMeta(Meta meta) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Usuario no encontrado");
      }

      final metaActualizada = meta.toJson();
      metaActualizada['uid'] = user.uid;

      await baseData.collection('Metas').doc(meta.id).update(metaActualizada); 
      getMetas(); 
    } catch (e) {
      throw Exception('Error al actualizar la meta: $e');
    }
  }

  clearData() {
    metas.clear();
  }
}

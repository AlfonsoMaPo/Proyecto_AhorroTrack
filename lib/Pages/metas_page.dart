import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/meta_controller.dart';
import 'package:myapp/Models/meta.dart';

class MetasPage extends StatelessWidget {
  const MetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MetaController metaController = Get.put(MetaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController descripcionController =
                      TextEditingController();
                  final TextEditingController montoController =
                      TextEditingController();
                  return AlertDialog(
                    title: const Text('Agregar Meta'),
                    content: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: descripcionController,
                              decoration: const InputDecoration(
                                labelText: 'Descripción',
                              ),
                            ),
                            TextField(
                              controller: montoController,
                              decoration: const InputDecoration(
                                labelText: 'Monto Objetivo',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            final nuevaMeta = Meta(
                              id: '',
                              descripcion: descripcionController.text,
                              montoObjetivo: double.parse(montoController.text),
                              uid: user.uid,
                            );
                            metaController.addMeta(nuevaMeta);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (metaController.metas.isEmpty) {
          return const Center(child: Text('No hay metas disponibles'));
        }
        return ListView.builder(
          itemCount: metaController.metas.length,
          itemBuilder: (context, index) {
            final meta = metaController.metas[index];
            return Card(
              child: ListTile(
                leading:const Icon(Icons.auto_graph),
                title: Text(meta.descripcion),
                subtitle: Text('Monto Objetivo: LPS ${meta.montoObjetivo}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    metaController.eliminarMeta(meta.id);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/reto_controller.dart';
import 'package:myapp/Models/retos.dart';

class RetosFinancierosPage extends StatelessWidget {
  const RetosFinancierosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RetoFinancieroController retoController = Get.put(RetoFinancieroController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Retos Financieros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController tituloController = TextEditingController();
                  final TextEditingController descripcionController = TextEditingController();
                  final TextEditingController fechaInicioController = TextEditingController();
                  final TextEditingController fechaFinController = TextEditingController();
                  
                  return AlertDialog(
                    title: const Text('Agregar Reto Financiero'),
                    content: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: tituloController,
                              decoration: const InputDecoration(
                                labelText: 'Título',
                              ),
                            ),
                            TextField(
                              controller: descripcionController,
                              decoration: const InputDecoration(
                                labelText: 'Descripción',
                              ),
                            ),
                            TextField(
                              controller: fechaInicioController,
                              decoration: const InputDecoration(
                                labelText: 'Fecha de Inicio (DD-MM-AAAA)',
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                            TextField(
                              controller: fechaFinController,
                              decoration: const InputDecoration(
                                labelText: 'Fecha de Fin (DD-MM-AAAA)',
                              ),
                              keyboardType: TextInputType.datetime,
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
                          if (tituloController.text.isEmpty ||
                         descripcionController.text.isEmpty || 
                         fechaInicioController.text.isEmpty || 
                         fechaFinController.text.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar( 
                            const SnackBar( content: 
                            Text('Por favor, completa todos los campos')
                            ), 
                            ); 
                            return; 
                          }
                          try { 
                            final User? user = FirebaseAuth.instance.currentUser; 
                            if (user != null) { 
                              final nuevoReto = RetoFinanciero( 
                                id: '',
                                titulo: tituloController.text,
                                descripcion: descripcionController.text,
                                completado: false,
                                fechaInicio: fechaInicioController.text,
                                fechaFin: fechaFinController.text,
                                uid: user.uid,
                                );
                              retoController.addRetoFinanciero(nuevoReto);
                            Navigator.pop(context); } 
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al agregar reto: $e')
                                ),
                              );
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
        if (retoController.retosFinancieros.isEmpty) {
          return const Center(
            child: Text('No hay retos financieros disponibles'
            ));
        }
        return ListView.builder(
          itemCount: retoController.retosFinancieros.length,
          itemBuilder: (context, index) {
            final reto = retoController.retosFinancieros[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.task_alt),
                title: Text(reto.titulo),
                subtitle: Text(reto.descripcion),
                trailing: Checkbox(
                  value: reto.completado,
                  onChanged: (bool? value) {
                    retoController.actualizarEstadoReto(reto.id, value ?? false);
                  },
                ),
                onTap: () {
                  showDialog( context: context, builder: (context) { 
                    return AlertDialog( 
                      title: Text(reto.titulo), 
                      content: Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [ 
                          Text('Descripción: ${reto.descripcion}'),
                          Text('Fecha de Inicio: ${reto.fechaInicio}'),
                          Text('Fecha de Fin: ${reto.fechaFin}'),
                          Text('Completado: ${reto.completado ? "Sí" : "No"}'), 
                          ], 
                        ), 
                          actions: [ 
                            TextButton( 
                              onPressed: () { 
                                Navigator.pop(context); 
                              }, 
                            child: const Text('Cerrar'), 
                          ), 
                        ], 
                      ); 
                    }, 
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}

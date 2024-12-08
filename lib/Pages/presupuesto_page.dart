import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';

class PresupuestoPage extends StatelessWidget {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PresupuestoController presupuestoController =
        Get.put(PresupuestoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuestos'),
      ),
      body: Obx(() {
        if (presupuestoController.presupuestos.isEmpty) {
          return const Center(child: Text('No hay presupuestos disponibles'));
        }
        return ListView.builder(
            itemCount: presupuestoController.presupuestos.length,
            itemBuilder: (context, index) {
              final supuesto = presupuestoController.presupuestos[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(supuesto.categoria),
                  subtitle: Text(
                      'Gastado:LPS${supuesto.gastoTotal}/${supuesto.montoTotal}'),
                  trailing: CircularProgressIndicator(
                    value: supuesto.gastoTotal / supuesto.montoTotal,
                  ),
                ),
              );
            });
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Widget/custom_presupuesto.dart';
//que dolor de cabeza fue todo esto
class PresupuestoPage extends StatelessWidget {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PresupuestoController presupuestoController =
        Get.put(PresupuestoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuestos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const CustomPresupuesto()
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (presupuestoController.presupuestos.isEmpty) {
          return const Center(child: Text('No hay presupuestos disponibles'));
        }
        return ListView.builder(
            itemCount: presupuestoController.presupuestos.length,
            itemBuilder: (context, index) {
              final supuesto = presupuestoController.presupuestos[index];
              return Dismissible(
              key: ValueKey(supuesto.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.red[100],
                ),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.edit,
                  color: Colors.green[100],
                ),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CustomPresupuesto(supuesto:supuesto),
                  ));
                  return false;
                } else {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Eliminar Presupuesto"),
                        content: const Text("¿Estás seguro de que quieres eliminar este presupuesto?"),
                        actions:[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Eliminar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  presupuestoController.eliminarPresupuestos(supuesto.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Presupuesto eliminado')),
                  );
                }
              },
              child: Card(
                child: ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(supuesto.categoria),
                    subtitle: Text(
                        'Gastado: LPS ${supuesto.gastoTotal}/${supuesto.montoTotal}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          value: supuesto.gastoTotal / supuesto.montoTotal,
                          
                        ),

                      ],
                    )
                  ),
                ),
              );
            });
      }),
    );
  }
}

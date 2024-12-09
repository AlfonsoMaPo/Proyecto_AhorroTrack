import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Controllers/ahorro_controller.dart';
import 'package:myapp/Controllers/meta_controller.dart';

class HistorialCrediticioPage extends StatelessWidget {
  const HistorialCrediticioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PresupuestoController presupuestoController = Get.put(PresupuestoController());
    final AhorroController ahorroController = Get.put(AhorroController());
    final MetaController metaController = Get.put(MetaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial Crediticio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Historial de Presupuestos',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              if (presupuestoController.presupuestos.isEmpty) {
                return const Center(child: Text('No hay presupuestos disponibles'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: presupuestoController.presupuestos.length,
                itemBuilder: (context, index) {
                  final presupuesto = presupuestoController.presupuestos[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet),
                      title: Text(presupuesto.categoria),
                      subtitle: Text(
                          'Gastado: LPS ${presupuesto.gastoTotal} / LPS ${presupuesto.montoTotal}'),
                      trailing: CircularProgressIndicator(
                        value: (presupuesto.gastoTotal / presupuesto.montoTotal),
                      ),
                    ),
                  );
                },
              );
            }),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Historial de Ahorros',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              if (ahorroController.ahorros.isEmpty) {
                return const Center(child: Text('No hay ahorros disponibles'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: ahorroController.ahorros.length,
                itemBuilder: (context, index) {
                  final ahorro = ahorroController.ahorros[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.savings),
                      title: Text(ahorro.categoria),
                      subtitle: Text(
                          'Monto: LPS ${ahorro.monto} / Meses: ${ahorro.meses}'),
                    ),
                  );
                },
              );
            }),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Progreso de Metas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              if (metaController.metas.isEmpty) {
                return const Center(child: Text('No hay metas disponibles'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: metaController.metas.length,
                itemBuilder: (context, index) {
                  final meta = metaController.metas[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.show_chart),
                      title: Text(meta.descripcion),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Progreso: LPS ${meta.progreso} / LPS ${meta.montoObjetivo}'),
                          LinearProgressIndicator(
                            value: meta.progreso / meta.montoObjetivo,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

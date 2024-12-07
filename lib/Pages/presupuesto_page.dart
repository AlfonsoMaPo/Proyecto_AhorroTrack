import 'package:flutter/material.dart';

class PresupuestoPage extends StatelessWidget {
  // ValueNotifier para gestionar presupuestos
  final ValueNotifier<List<Map<String, dynamic>>> presupuestosNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

   PresupuestoPage({super.key});

  // Método para agregar un nuevo presupuesto
agregarPresupuesto(BuildContext context) {
    String nombre = '';
    double monto = 0.0;
    String fecha = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nuevo Presupuesto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  monto = double.tryParse(value) ?? 0.0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Fecha'),
                onChanged: (value) {
                  fecha = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (nombre.isNotEmpty && monto > 0 && fecha.isNotEmpty) {
                  // Agregar nuevo presupuesto
                  presupuestosNotifier.value = [
                    ...presupuestosNotifier.value,
                    {"nombre": nombre, "monto": monto, "fecha": fecha}
                  ];
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Presupuestos'),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: presupuestosNotifier,
        builder: (context, presupuestos, _) {
          return ListView.builder(
            itemCount: presupuestos.length,
            itemBuilder: (context, index) {
              final presupuesto = presupuestos[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: Text(presupuesto['nombre']),
                  subtitle: Text(
                      "Monto: L. ${presupuesto['monto']} - Fecha: ${presupuesto['fecha']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Eliminar presupuesto
                      presupuestosNotifier.value = List.from(presupuestos)
                        ..removeAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => agregarPresupuesto(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

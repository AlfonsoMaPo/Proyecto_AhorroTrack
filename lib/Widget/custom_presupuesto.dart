import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Models/presupuesto.dart';

class CustomPresupuesto extends StatelessWidget {
  final Presupuesto? supuesto;

  const CustomPresupuesto({super.key, this.supuesto});

  @override
  Widget build(BuildContext context) {
    final PresupuestoController presupuestoController =
        Get.find<PresupuestoController>();
    final TextEditingController categoriaController =
        TextEditingController(text: supuesto?.categoria ?? '');
    final TextEditingController montoTotalController =
        TextEditingController(text: supuesto?.montoTotal.toString() ?? '');
    final TextEditingController gastoTotalController =
        TextEditingController(text: supuesto?.gastoTotal.toString() ?? '');

    bool validarFormulario() {
      if (categoriaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, ingresa una categoría')),
        );
        return false;
      }
      if (montoTotalController.text.isEmpty ||
          double.tryParse(montoTotalController.text) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Por favor, ingresa un monto total válido')),
        );
        return false;
      }
      if (gastoTotalController.text.isEmpty ||
          double.tryParse(gastoTotalController.text) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Por favor, ingresa un gasto actual válido')),
        );
        return false;
      }
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            supuesto == null ? 'Agregar Presupuesto' : 'Editar Presupuesto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                )
            ),

            const SizedBox(height: 20),

            TextField(
                controller: montoTotalController,
                decoration: const InputDecoration(
                  labelText: 'Monto Total',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            TextField(
                controller: gastoTotalController,
                decoration: const InputDecoration(
                  labelText: 'Gasto Total',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money_off),
                ),
                keyboardType: TextInputType.number,
            ),

            const SizedBox(height:20),

            ElevatedButton(
              onPressed:(){
                if(validarFormulario()){
                  final nuevoPresupuesto = Presupuesto( 
                    id: supuesto?.id ?? '',
                    categoria: categoriaController.text,
                    montoTotal: double.parse(montoTotalController.text),
                    gastoTotal: double.parse(gastoTotalController.text),
                  );
                  if (supuesto == null) {
                   presupuestoController.addPresupuestos(nuevoPresupuesto); 
                  }else { 
                    presupuestoController.actualizarPresupuestos(nuevoPresupuesto);
                  } 
                  Navigator.of(context).pop(); }
              },
              child: Text(
                supuesto == null ? 'Agregar' : 'Guardar Cambios'
                ),
              ),
          ],
        ),
      ),
    );
  }
}

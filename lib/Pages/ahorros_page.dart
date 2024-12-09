import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ahorro_controller.dart';
import 'package:myapp/Models/ahorro.dart';

class AhorrosPage extends StatelessWidget {
  const AhorrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AhorroController ahorroController = Get.put(AhorroController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahorros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(context:context,builder:(context){
                final TextEditingController categoriaController = TextEditingController();
                final TextEditingController montoController = TextEditingController();
                final TextEditingController mesesController = TextEditingController();
              return AlertDialog(
                title:const Text('Agregar Ahorro'),
                content:SingleChildScrollView(
                  child:Padding(
                    padding:const EdgeInsets.all(10),
                    child: Column(
                  mainAxisSize:MainAxisSize.min,
                  children: [
                    TextField(
                      controller: categoriaController,
                      decoration:const InputDecoration(labelText: 'Categoría'),
                      ),
                    TextField(
                      controller: montoController,
                      decoration:const InputDecoration(labelText: 'Monto'),
                      keyboardType: TextInputType.number,
                      ),
                    TextField(
                      controller: mesesController,
                      decoration:const InputDecoration(labelText: 'Meses'),
                      keyboardType: TextInputType.number,
                      ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: () {
                        Navigator.pop(context); },
                        child:const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) { 
                            final nuevoAhorro = Ahorro( 
                              id: '',
                              monto: montoController.text,
                              categoria: categoriaController.text,
                              meses: mesesController.text,
                              uid: user.uid,
                              );
                              ahorroController.addAhorro(nuevoAhorro);
                              Navigator.pop(context);
                              }
                            },
                          child:const Text('Guardar'),
                        )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child:  Text(
              'Aquí puedes guardar y llevar el registro de los ahorros que has conseguido',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ),
      Obx(() {
      if (ahorroController.ahorros.isEmpty) {
        return const Center(child: Text('No hay ahorros disponibles'));
      }
      return Expanded( 
        child: ListView.builder(
          itemCount: ahorroController.ahorros.length,
          itemBuilder: (context, index) {
            final ahorro = ahorroController.ahorros[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.savings),
                title: Text('Monto: LPS ${ahorro.monto}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categoría: ${ahorro.categoria}'),
                    Text('Meses: ${ahorro.meses}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ahorroController.eliminarAhorro(ahorro.id);
                  },
                ),
              ),
            );
           },
         ),
         );
        }),
      ],
      ),
    );
  }
}

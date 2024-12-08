import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

String iniciales(String usuario){
  return usuario.isNotEmpty?usuario[0].toUpperCase():"U";
}

logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Get.find<PresupuestoController>().clearData();
    Navigator.pushReplacementNamed(context, '/');
    }catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    } 
    
  }

  @override
  Widget build(BuildContext context) {
    final User? usuario = FirebaseAuth.instance.currentUser;
     final PresupuestoController presupuestoController = Get.put(PresupuestoController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.green.shade600,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(
                usuario?.displayName ?? 'Usuario',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              
              accountEmail: Text(
                usuario?.email??'Usuario@gmail.com',
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              currentAccountPicture:Padding(
                padding:const EdgeInsets.all(6),
                child:CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  iniciales(usuario?.displayName??'U'),
                  style:const TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              )  
            ),

            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Presupuestos'),
              onTap: () {
                Navigator.pushNamed(context, '/presupuestos');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text('Ahorros'),
              onTap: () {
                Navigator.pushNamed(context, '/ahorros');
              },
            ),

            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Metas'),
              onTap: () {
                Navigator.pushNamed(context, '/metas');
              },
            ),

            const Divider(),
            /*ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                
              },
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
              }, 
            ),*/
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),

      body:Obx((){
        
        final ultimoPresupuesto = presupuestoController.ultimoPresupuesto.value;
        if (ultimoPresupuesto == null) {
         return const Center(
          child: Text('No hay presupuestos disponibles')
          );
        }
        return Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:  EdgeInsets.all(8.0),
             child: Text(
              "Último presupuesto guardado:",
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
               ),
             ),
            ),
        Card(
        child: ListTile(
          leading: const Icon(Icons.category),
          title: Text(ultimoPresupuesto.categoria),
          subtitle: Text(
              'Gastado: LPS ${ultimoPresupuesto.gastoTotal} / LPS ${ultimoPresupuesto.montoTotal}'),
          trailing: CircularProgressIndicator(
            value: (ultimoPresupuesto.gastoTotal / ultimoPresupuesto.montoTotal),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/presupuestos');
          },
             ),
           )
          ],
        );
      }),
    );
  }
}

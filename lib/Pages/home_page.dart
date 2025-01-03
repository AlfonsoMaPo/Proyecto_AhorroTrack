import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ahorro_controller.dart';
import 'package:myapp/Controllers/meta_controller.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Controllers/reto_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String iniciales(String usuario) {
    return usuario.isNotEmpty ? usuario[0].toUpperCase() : "U";
  }

  logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.find<PresupuestoController>().clearData();
      Get.find<MetaController>().clearData();
      Get.find<AhorroController>().clearDataahorro();
      Get.find<RetoFinancieroController>().clearRetoData();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  switchAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      throw Exception('Error al cambiar de cuenta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? usuario = FirebaseAuth.instance.currentUser;
    final PresupuestoController presupuestoController =
        Get.put(PresupuestoController());
  final AhorroController ahorroController = Get.put(AhorroController());
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        ),
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
                  usuario?.email ?? 'Usuario@gmail.com',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                currentAccountPicture: Padding(
                  padding: const EdgeInsets.all(6),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      iniciales(usuario?.displayName ?? 'U'),
                      style:
                          const TextStyle(fontSize: 40.0, color: Colors.blue),
                    ),
                  ),
                ),
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
            ListTile( 
            leading: const Icon(Icons.history), 
            title: const Text('Historial Crediticio'), 
            onTap: () { 
              Navigator.pushNamed(context, '/historial'); 
              },
            ),
            ListTile(
               leading: const Icon(Icons.task), 
               title: const Text('Retos Financieros'), 
               onTap: () { 
                Navigator.pushNamed(context, '/retos'); 
                }, 
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.switch_access_shortcut_rounded),
              title: const Text('Cambiar cuenta'),
              onTap: () {
                switchAccount(context);
                
              },
            ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenid@, ${usuario?.displayName ?? 'Usuario'}!',
              style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold
              ),
            ),
          ),
          Obx(() {
            final ultimoPresupuesto =
                presupuestoController.ultimoPresupuesto.value;
            if (ultimoPresupuesto == null) {
              return const Center(
                  child: Text('No hay presupuestos disponibles')
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
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
                      value: (ultimoPresupuesto.gastoTotal/ultimoPresupuesto.montoTotal), 
                      color: (ultimoPresupuesto.gastoTotal>ultimoPresupuesto.montoTotal) ? Colors.red : Colors.green,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/presupuestos');
                    },
                  ),
                )
              ],
            );
          }),
          Obx(() { 
            final ultimaMeta = Get.find<MetaController>().ultimaMeta.value; 
            if (ultimaMeta == null) {
              return const Center(
                child: Text('No hay metas disponibles')
                );
                } return Column(
                   crossAxisAlignment: CrossAxisAlignment.start, 
                   children: [ 
                    const Padding( 
                      padding: EdgeInsets.all(8.0), 
                      child: Text( "Última meta guardada:", 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontWeight: 
                        FontWeight.bold, 
                      ),
                    ), 
                  ), Card(
                    child: ListTile(
                      leading: const Icon(Icons.show_chart),
                      title: Text(ultimaMeta.descripcion),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Progreso: LPS ${ultimaMeta.progreso} / LPS ${ultimaMeta.montoObjetivo}'),
                          LinearProgressIndicator(
                            value: ultimaMeta.progreso / ultimaMeta.montoObjetivo,
                          ),
                        ],
                      ),
                    ),
                  ), 
                ], 
              ); 
          }),Obx(() { 
            final ultimoAhorro = ahorroController.ultimoAhorro.value; 
            if (ultimoAhorro == null) { 
              return const Center(
                child: Text('No hay ahorros disponibles')
                ); 
                } return Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ const Padding(
                     padding: EdgeInsets.all(8.0),
                      child: Text( "Último ahorro guardado:", 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                      ), 
                    ), 
                  ), 
                Card( 
                child: ListTile( 
                leading: const Icon(Icons.savings), 
                title: Text(ultimoAhorro.categoria),
                subtitle: Text( 'Monto: LPS ${ultimoAhorro.monto} / Meses: ${ultimoAhorro.meses}'), 
                onTap: () { 
                  Navigator.pushNamed(context, '/ahorros'); 
              }, 
             ), 
           ), 
          ],
         );
        }),
        ],
      ),
    );
  }
}

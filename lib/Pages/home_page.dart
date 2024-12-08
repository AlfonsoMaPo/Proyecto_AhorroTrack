import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

String iniciales(String usuario){
  return usuario.isNotEmpty?usuario[0].toUpperCase():"U";
}
  @override
  Widget build(BuildContext context) {
    final User? usuario = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AhorroTrack'),
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
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Bienvenido a AhorroTrack!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, size: 48),
                title: Text('Saldo Total'),
                subtitle: Text('L. 10,000.00'),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

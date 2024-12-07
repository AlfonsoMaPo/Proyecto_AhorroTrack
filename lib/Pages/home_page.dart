import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AhorroTrack'),
        backgroundColor: Colors.green.shade600,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(
                'Usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              accountEmail: Text(
                'usuario@correo.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'U',
                  style: TextStyle(fontSize: 40.0, color: Colors.blue),
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                // Navegar a la página de configuración (a implementar)
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
                // Navegar a la página de ayuda (a implementar)
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Lógica de logout (a implementar)
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

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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Presupuestos'),
              onTap: () {
                Navigator.pushNamed(context, '/presupuesto');
              },
            ),
            ListTile(
              leading:const Icon(Icons.savings),
              title:const Text('Ahorros'),
              onTap: () {
                Navigator.pushNamed(context, '/ahorros');
              },
            ),
            ListTile(
              leading:const Icon(Icons.show_chart),
              title:const Text('Metas'),
              onTap: () {
                Navigator.pushNamed(context, '/metas');
              },
            ),
          ],
        ),
      ),
      body: const Padding(
        padding:  EdgeInsets.all(16.0),
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

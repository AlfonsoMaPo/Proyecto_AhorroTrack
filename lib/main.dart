import 'package:flutter/material.dart';
import 'package:myapp/Pages/home_page.dart';

void main() {
  runApp(const AhorroTrackApp());
}

class AhorroTrackApp extends StatelessWidget {
  const AhorroTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AhorroTrack',
      initialRoute: '/',
      routes: {
        '/':(context)=> const HomePage(),
        // '/':(context)=> AhorroPage(),
        // '/':(context)=> PresupuestoPage(),
        // '/':(context)=> MetasPage(),
      },
    );
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
      ),
      body: const Center(

      
      ),
      
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


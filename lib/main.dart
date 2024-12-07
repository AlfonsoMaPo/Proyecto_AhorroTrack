import 'package:flutter/material.dart';
import 'package:myapp/Pages/ahorros_page.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/metas_page.dart';
import 'package:myapp/Pages/presupuesto_page.dart';
import 'package:myapp/Security/login_page.dart';
import 'package:myapp/Security/registration.dart';

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
        '/':(context)=> const LoginPage(),
        '/home':(context)=> const HomePage(),
        '/ahorros':(context)=> const AhorrosPage(),
        '/presupuestos':(context)=>  PresupuestoPage(),
        '/metas':(context)=> const MetasPage(),
        '/registro':(context)=> const RegistroPage(),
      },
    );
  }
}







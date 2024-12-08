import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/Pages/ahorros_page.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/metas_page.dart';
import 'package:myapp/Pages/presupuesto_page.dart';
import 'package:myapp/Security/login_page.dart';
import 'package:myapp/Security/registration.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/presupuestos':(context)=> PresupuestoPage(),
        '/metas':(context)=> const MetasPage(),
        '/registro':(context)=> const RegistroPage(),
      },
    );
  }
}

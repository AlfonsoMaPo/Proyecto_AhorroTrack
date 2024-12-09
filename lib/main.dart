import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Pages/ahorros_page.dart';
import 'package:myapp/Pages/historial_crediticiopage.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/metas_page.dart';
import 'package:myapp/Pages/presupuesto_page.dart';
import 'package:myapp/Pages/retos_page.dart';
import 'package:myapp/Security/login_page.dart';
import 'package:myapp/Security/registration.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(PresupuestoController());
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
        '/presupuestos':(context)=> const PresupuestoPage(),
        '/metas':(context)=> const MetasPage(),
        '/registro':(context)=> const RegistroPage(),
        '/historial':(context)=> const HistorialCrediticioPage(),
        '/retos':(context)=> const RetosFinancierosPage(),
      },
    );
  }
}

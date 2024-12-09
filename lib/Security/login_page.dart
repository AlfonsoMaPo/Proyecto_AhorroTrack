import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ahorro_controller.dart';
import 'package:myapp/Controllers/meta_controller.dart';
import 'package:myapp/Controllers/presupuesto_controller.dart';
import 'package:myapp/Widget/custom_login.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PresupuestoController>()) {
      Get.put(PresupuestoController());
    }
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;

    login() async {
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (!Get.isRegistered<PresupuestoController>()) {
        Get.put(PresupuestoController());
        }
        Get.find<PresupuestoController>().getPresupuestos();
        Get.find<PresupuestoController>().getUltimoPresupuesto();

        if (!Get.isRegistered<AhorroController>()) {
           Get.put(AhorroController()); 
          } 
           Get.find<AhorroController>().getAhorros(); 
           Get.find<AhorroController>().getUltimoAhorro();

        if (!Get.isRegistered<MetaController>()) {
           Get.put(MetaController()); 
          } 
           Get.find<MetaController>().getMetas(); 
          Get.find<MetaController>().getUltimaMeta(); 
           
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(e.toString())),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                const SizedBox(height: 80),
               
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.oQy8D3p7rGB3cNKlQVqFAQHaHa?rs=1&pid=ImgDetMain',
                  ),
                ),

                const SizedBox(height: 20.0),
                const Text(
                  '¡Bienvenido a AhorroTrack!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0),
                
                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                
                CustomLogin(
                  emailController: emailController,
                  title: 'Correo electrónico',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.email, color: Colors.green),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10.0),
                
                CustomLogin(
                  emailController: passwordController,
                  title: 'Contraseña',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.lock, color: Colors.green),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20.0),
                
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Iniciar sesión', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  child: const Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

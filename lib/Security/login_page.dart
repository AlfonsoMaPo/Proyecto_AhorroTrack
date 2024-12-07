import 'package:flutter/material.dart';
import 'package:myapp/Widget/custom_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                  emailController: usernameController,
                  title: 'Nombre de usuario',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.person, color: Colors.green),
                ),
                const SizedBox(height: 10.0),
                CustomLogin(
                  emailController: passwordController,
                  title: 'Contraseña',
                  ocupalengthmax: false,
                  icon:const Icon(Icons.lock, color: Colors.green),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child:const Text('Iniciar sesión', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  child:const Text(
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
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Widget/custom_registration.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;

    registro() async {
      try {
        UserCredential credencial=await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await credencial.user?.updateDisplayName(userController.text);
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
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
                  '¡Regístrate en AhorroTrack!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10.0),
                const Text(
                  'Crea una cuenta para comenzar',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20.0),
                CustomRegistration(
                  controller: userController,
                  title: 'Usuario',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.person, color: Colors.green),
                ),

                const SizedBox(height: 10.0),
                CustomRegistration(
                  controller: emailController,
                  title: 'Correo electrónico',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.email, color: Colors.green),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10.0),
                CustomRegistration(
                  controller: passwordController,
                  title: 'Contraseña',
                  ocupalengthmax: false,
                  icon: const Icon(Icons.lock, color: Colors.green),
                  keyboardType: TextInputType.visiblePassword,
                ),

                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: registro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Registrar', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
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

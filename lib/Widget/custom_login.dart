import 'package:flutter/material.dart';

class CustomLogin extends StatefulWidget {
  const CustomLogin({
    super.key,
    required this.emailController,
    required this.title,
    required this.ocupalengthmax,
    this.length,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController emailController;
  final String title;
  final TextInputType keyboardType;
  final bool ocupalengthmax;
  final int? length;
  final Icon icon;

  @override
  State<CustomLogin> createState() => _CustomLoginState();
}

class _CustomLoginState extends State<CustomLogin> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.emailController,
      keyboardType: widget.keyboardType,
      obscureText: widget.keyboardType == TextInputType.visiblePassword ? _obscureText : false,
      style: const TextStyle(color: Colors.blue), 
      decoration: InputDecoration(
        hintText: 'Ingrese su ${widget.title}',
        label: Text(widget.title, style:const TextStyle(color: Colors.green)), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0), 
          borderSide:const BorderSide(color: Colors.green), 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide:const BorderSide(color: Colors.green),
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      maxLength: widget.ocupalengthmax ? widget.length : null,
    );
  }
}

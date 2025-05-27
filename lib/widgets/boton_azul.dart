import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: Colors.black,
        backgroundColor: Colors.blue, // reemplaza 'primary'
        foregroundColor: Colors.white, // reemplaza 'onPrimary'
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 55),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}

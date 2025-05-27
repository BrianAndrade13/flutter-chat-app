import 'package:flutter/material.dart';

class LoadingPages extends StatelessWidget {
  const LoadingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Page'),
      centerTitle: true,
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
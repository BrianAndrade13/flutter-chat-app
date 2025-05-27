import 'package:flutter/material.dart';

class ChatPages extends StatelessWidget {
  const ChatPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      centerTitle: true,
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}